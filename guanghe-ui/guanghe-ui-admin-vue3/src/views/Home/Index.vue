<template>
  <div>
    <el-card shadow="never">
      <el-skeleton :loading="loading" animated>
        <el-row :gutter="16" justify="space-between">
          <el-col :xl="12" :lg="12" :md="24" :sm="24" :xs="24">
            <div class="flex items-center">
              <el-avatar :src="avatar" :size="70" class="mr-16px">
                <img src="@/assets/imgs/avatar.png" alt="" />
              </el-avatar>
              <div>
                <div class="text-20px">
                  {{ t('workplace.welcome') }} {{ username }} {{ t('workplace.happyDay') }}
                </div>
                <div class="mt-10px text-14px text-gray-500">
                  {{ t('workplace.currentModules') }}
                </div>
              </div>
            </div>
          </el-col>
          <el-col :xl="12" :lg="12" :md="24" :sm="24" :xs="24">
            <div class="h-70px flex items-center justify-end lt-sm:mt-10px">
              <template v-for="(item, index) in statList" :key="item.label">
                <el-divider v-if="index > 0" direction="vertical" border-style="dashed" />
                <div class="px-8px text-right">
                  <div class="mb-16px text-14px text-gray-400">{{ item.label }}</div>
                  <CountTo
                    class="text-20px"
                    :start-val="0"
                    :end-val="item.value"
                    :duration="2600"
                  />
                </div>
              </template>
            </div>
          </el-col>
        </el-row>
      </el-skeleton>
    </el-card>
  </div>

  <el-row class="mt-8px" :gutter="8" justify="space-between">
    <el-col :xl="24" :lg="24" :md="24" :sm="24" :xs="24" class="mb-8px">
      <el-card shadow="never">
        <template #header>
          <div class="h-3 flex justify-between">
            <span>{{ t('workplace.shortcutOperation') }}</span>
          </div>
        </template>
        <el-skeleton :loading="loading" animated>
          <el-row>
            <el-col v-for="item in shortcut" :key="`team-${item.name}`" :span="8" class="mb-8px">
              <div class="flex items-center">
                <Icon :icon="item.icon" class="mr-8px" :style="{ color: item.color }" />
                <el-link type="default" :underline="false" @click="handleShortcutClick(item.url)">
                  {{ item.name }}
                </el-link>
              </div>
            </el-col>
          </el-row>
        </el-skeleton>
      </el-card>
    </el-col>
  </el-row>
</template>
<script lang="ts" setup>
import { useUserStore } from '@/store/modules/user'
import type { Shortcut, WorkplaceTotal } from './types'
import { useRouter } from 'vue-router'
import { getUserPage } from '@/api/system/user'
import { getRolePage } from '@/api/system/role'
import { getSimpleDeptList } from '@/api/system/dept'
import { getSimpleMenusList } from '@/api/system/menu'

defineOptions({ name: 'Index' })

const { t } = useI18n()
const router = useRouter()
const userStore = useUserStore()
const loading = ref(true)
const avatar = userStore.getUser.avatar
const username = userStore.getUser.nickname

// 平台规模统计。user/role 两个接口需要查询权限，无权限的用户自动隐藏对应指标
const totalState = reactive<WorkplaceTotal>({ user: 0, role: 0, dept: 0, menu: 0 })
const statList = computed(() =>
  [
    { key: 'user', label: t('workplace.userTotal'), value: totalState.user },
    { key: 'role', label: t('workplace.roleTotal'), value: totalState.role },
    { key: 'dept', label: t('workplace.deptTotal'), value: totalState.dept },
    { key: 'menu', label: t('workplace.menuTotal'), value: totalState.menu }
  ].filter((item) => item.value > 0)
)

const getTotal = async () => {
  const [userRes, roleRes, deptRes, menuRes] = await Promise.allSettled([
    getUserPage({ pageNo: 1, pageSize: 1 }),
    getRolePage({ pageNo: 1, pageSize: 1 }),
    getSimpleDeptList(),
    getSimpleMenusList()
  ])
  if (userRes.status === 'fulfilled') {
    totalState.user = userRes.value.total
  }
  if (roleRes.status === 'fulfilled') {
    totalState.role = roleRes.value.total
  }
  if (deptRes.status === 'fulfilled') {
    totalState.dept = deptRes.value.length
  }
  if (menuRes.status === 'fulfilled') {
    totalState.menu = menuRes.value.length
  }
}

// 快捷入口，仅指向已启用模块的真实路由
let shortcut = reactive<Shortcut[]>([])

const getShortcut = async () => {
  const data = [
    { name: '用户管理', icon: 'ep:user', url: '/system/user', color: '#1fdaca' },
    { name: '角色管理', icon: 'ep:user-filled', url: '/system/role', color: '#ff6b6b' },
    { name: '部门管理', icon: 'ep:office-building', url: '/system/dept', color: '#7c3aed' },
    { name: '菜单管理', icon: 'ep:menu', url: '/system/menu', color: '#3fb27f' },
    { name: '字典管理', icon: 'ep:collection', url: '/system/dict', color: '#4daf1b' },
    { name: '代码生成', icon: 'ep:magic-stick', url: '/infra/codegen', color: '#1a73e8' },
    { name: '定时任务', icon: 'ep:timer', url: '/infra/job', color: '#e6a23c' },
    { name: '配置管理', icon: 'ep:setting', url: '/infra/config', color: '#909399' }
  ]
  shortcut = Object.assign(shortcut, data)
}

const getAllApi = async () => {
  await Promise.all([getTotal(), getShortcut()])
  loading.value = false
}

const handleShortcutClick = (url: string) => {
  router.push(url)
}

getAllApi()
</script>
