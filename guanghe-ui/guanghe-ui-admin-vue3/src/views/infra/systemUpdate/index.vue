<template>
  <ContentWrap>
    <!-- 状态卡片 -->
    <el-descriptions :column="3" border>
      <el-descriptions-item label="当前后端 jar">{{ status.currentBackendJar || '-' }}</el-descriptions-item>
      <el-descriptions-item label="上次更新时间">{{ status.lastUpdateTime || '-' }}</el-descriptions-item>
      <el-descriptions-item label="上次更新结果">
        <el-tag v-if="status.lastUpdateResult === 'success'" type="success">成功</el-tag>
        <el-tag v-else-if="status.lastUpdateResult === 'rollback-success'" type="warning">回滚成功</el-tag>
        <el-tag v-else-if="status.lastUpdateResult && status.lastUpdateResult.includes('failed')" type="danger">失败</el-tag>
        <span v-else>-</span>
      </el-descriptions-item>
    </el-descriptions>
    <div v-if="status.updating" class="mt-16px">
      <el-alert :title="status.progressMessage || '更新中...'" type="info" show-icon :closable="false" />
      <el-progress :percentage="100" status="warning" :indeterminate="true" :duration="3" class="mt-8px" />
    </div>
  </ContentWrap>

  <ContentWrap>
    <el-tabs v-model="activeTab">
      <!-- 后端更新 -->
      <el-tab-pane label="后端更新" name="backend">
        <el-upload
          ref="backendUploadRef"
          drag
          :auto-upload="false"
          :limit="1"
          accept=".jar"
          :on-change="handleBackendFileChange"
          :on-exceed="() => message.warning('仅允许上传一个文件')"
        >
          <Icon icon="ep:upload-filled" class="el-icon--upload" />
          <div class="el-upload__text">将 guanghe-server*.jar 拖到此处，或 <em>点击上传</em></div>
        </el-upload>
        <div v-if="backendStaged" class="mt-12px text-14px">
          <el-icon color="#67c23a"><SuccessFilled /></el-icon>
          {{ backendStaged.fileName }}（{{ formatSize(backendStaged.fileSize) }}）
        </div>
      </el-tab-pane>

      <!-- 前端更新 -->
      <el-tab-pane label="前端更新" name="frontend">
        <el-upload
          ref="frontendUploadRef"
          drag
          :auto-upload="false"
          :limit="1"
          accept=".zip"
          :on-change="handleFrontendFileChange"
          :on-exceed="() => message.warning('仅允许上传一个文件')"
        >
          <Icon icon="ep:upload-filled" class="el-icon--upload" />
          <div class="el-upload__text">将 html.zip 拖到此处，或 <em>点击上传</em></div>
        </el-upload>
        <div v-if="frontendStaged" class="mt-12px text-14px">
          <el-icon color="#67c23a"><SuccessFilled /></el-icon>
          {{ frontendStaged.fileName }}（{{ formatSize(frontendStaged.fileSize) }}）
          <div v-if="frontendStaged.validationInfo" class="text-gray-400 text-12px mt-4px">
            {{ frontendStaged.validationInfo }}
          </div>
        </div>
      </el-tab-pane>
    </el-tabs>

    <div class="mt-16px flex justify-end">
      <el-button
        type="primary"
        :loading="uploading"
        :disabled="!canApply || status.updating"
        v-hasPermi="['infra:system-update:upload']"
        @click="handleUploadAndApply"
      >
        上传并更新系统
      </el-button>
    </div>
  </ContentWrap>

  <ContentWrap>
    <template #header>
      <span>备份与回滚</span>
    </template>
    <el-table :data="status.backups" v-loading="loadingBackups" stripe>
      <el-table-column prop="timestamp" label="备份时间" width="180" />
      <el-table-column prop="type" label="类型" width="100">
        <template #default="{ row }">
          <el-tag v-if="row.type === 'both'" type="success">完整</el-tag>
          <el-tag v-else-if="row.type === 'backend'">后端</el-tag>
          <el-tag v-else type="info">前端</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="description" label="描述" />
      <el-table-column label="操作" width="120" fixed="right">
        <template #default="{ row }">
          <el-button
            link
            type="danger"
            v-hasPermi="['infra:system-update:rollback']"
            :disabled="status.updating"
            @click="handleRollback(row.timestamp)"
          >
            回滚
          </el-button>
        </template>
      </el-table-column>
    </el-table>
  </ContentWrap>
</template>

<script lang="ts" setup>
import { SuccessFilled } from '@element-plus/icons-vue'
import * as SystemUpdateApi from '@/api/infra/systemUpdate'
import type { SystemUpdateStatusVO, SystemUpdateUploadRespVO } from '@/api/infra/systemUpdate'
import { checkPermi } from '@/utils/permission'

defineOptions({ name: 'InfraSystemUpdate' })

const message = useMessage()

// ==================== state ====================
const activeTab = ref('backend')
const uploading = ref(false)
const loadingBackups = ref(false)

const status = reactive<SystemUpdateStatusVO>({
  updating: false,
  progressMessage: '',
  lastUpdateTime: null,
  lastUpdateResult: null,
  currentBackendJar: null,
  backups: []
})

const backendStaged = ref<SystemUpdateUploadRespVO | null>(null)
const frontendStaged = ref<SystemUpdateUploadRespVO | null>(null)

let pollTimer: ReturnType<typeof setInterval> | null = null

// ==================== computed ====================
const canApply = computed(() => !!backendStaged.value || !!frontendStaged.value)

// ==================== lifecycle ====================
onMounted(async () => {
  await refreshStatus()
})

onUnmounted(() => {
  stopPolling()
})

// ==================== methods ====================
const refreshStatus = async () => {
  try {
    const data = await SystemUpdateApi.getUpdateStatus()
    Object.assign(status, data)
    if (status.updating) {
      startPolling()
    } else {
      stopPolling()
    }
  } catch (e) {
    // ignore polling errors
  }
}

const startPolling = () => {
  if (pollTimer) return
  pollTimer = setInterval(refreshStatus, 3000)
}

const stopPolling = () => {
  if (pollTimer) {
    clearInterval(pollTimer)
    pollTimer = null
  }
}

const handleBackendFileChange = (file: any) => {
  // el-upload on-change gives { raw: File }
  // We just store the raw file reference; actual upload happens on button click
  backendStaged.value = {
    tempFilePath: '',
    fileName: file.raw?.name || file.name || '',
    fileSize: file.raw?.size || file.size || 0,
    type: 'backend',
    validationInfo: ''
  }
  // Store raw file for later upload
  ;(backendStaged.value as any)._rawFile = file.raw || file
}

const handleFrontendFileChange = (file: any) => {
  frontendStaged.value = {
    tempFilePath: '',
    fileName: file.raw?.name || file.name || '',
    fileSize: file.raw?.size || file.size || 0,
    type: 'frontend',
    validationInfo: ''
  }
  ;(frontendStaged.value as any)._rawFile = file.raw || file
}

const handleUploadAndApply = async () => {
  if (!checkPermi(['infra:system-update:upload'])) {
    message.error('没有上传权限')
    return
  }
  if (!checkPermi(['infra:system-update:apply'])) {
    message.error('没有应用更新权限')
    return
  }

  try {
    await message.confirm('确认要更新系统吗？后端更新将导致服务短暂中断。')
  } catch {
    return // cancelled
  }

  uploading.value = true
  let backendTempPath = ''
  let frontendTempPath = ''

  try {
    // Upload backend
    if (backendStaged.value) {
      const rawFile = (backendStaged.value as any)._rawFile as File
      const resp = await SystemUpdateApi.uploadUpdatePackage(
        { file: rawFile, type: 'backend' },
        undefined
      )
      backendTempPath = resp.tempFilePath
      backendStaged.value.validationInfo = resp.validationInfo || ''
    }

    // Upload frontend
    if (frontendStaged.value) {
      const rawFile = (frontendStaged.value as any)._rawFile as File
      const resp = await SystemUpdateApi.uploadUpdatePackage(
        { file: rawFile, type: 'frontend' },
        undefined
      )
      frontendTempPath = resp.tempFilePath
      frontendStaged.value.validationInfo = resp.validationInfo || ''
    }

    // Apply
    await SystemUpdateApi.applyUpdate({
      backendTempPath: backendTempPath || undefined,
      frontendTempPath: frontendTempPath || undefined
    })

    message.success('更新指令已发送，系统将自动重启')
    startPolling()
    await refreshStatus()
  } catch (e: any) {
    message.error(e?.message || '更新失败')
  } finally {
    uploading.value = false
  }
}

const handleRollback = async (timestamp: string) => {
  try {
    await message.confirm(`确认要回滚到 ${timestamp} 的备份吗？后端将重启。`)
  } catch {
    return
  }

  try {
    await SystemUpdateApi.rollbackUpdate({ backupTimestamp: timestamp })
    message.success('回滚指令已发送，系统将自动重启')
    startPolling()
    await refreshStatus()
  } catch (e: any) {
    message.error(e?.message || '回滚失败')
  }
}

const formatSize = (bytes: number) => {
  if (bytes < 1024) return bytes + ' B'
  if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB'
  return (bytes / (1024 * 1024)).toFixed(1) + ' MB'
}
</script>
