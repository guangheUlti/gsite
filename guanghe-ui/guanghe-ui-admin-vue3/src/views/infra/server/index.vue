<template>

  <ContentWrap :bodyStyle="{ padding: '0px' }" class="!mb-0">
    <IFrame v-if="!loading" v-loading="loading" :src="src" />
  </ContentWrap>
</template>
<script lang="ts" setup>
import * as ConfigApi from '@/api/infra/config'

defineOptions({ name: 'InfraAdminServer' })

const loading = ref(true) // 是否加载中
const src = ref(import.meta.env.VITE_BASE_URL + '/admin/applications')

/** 初始化 */
onMounted(async () => {
  try {
    // 友情提示：若出现 404，请确认 Spring Boot Admin 已启动，并检查配置项 url.spring-boot-admin
    const data = await ConfigApi.getConfigKey('url.spring-boot-admin')
    if (data && data.length > 0) {
      src.value = data
    }
  } finally {
    loading.value = false
  }
})
</script>
