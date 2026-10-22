<script lang="ts" setup>
import { useRoute } from 'vue-router'
import { useTagsViewStore } from '@/store/modules/tagsView'
import { useAppStore } from '@/store/modules/app'
import { Footer } from '@/layout/components/Footer'

defineOptions({ name: 'AppView' })

const appStore = useAppStore()
const route = useRoute()

// 首页是全屏品牌页：内容区不留内边距，也不显示页脚，让面板真正铺满整个标签页
const isFullScreenPage = computed(() => route.name === 'Index')

const footer = computed(() => appStore.getFooter && !isFullScreenPage.value)

const tagsViewStore = useTagsViewStore()

const getCaches = computed((): string[] => {
  return tagsViewStore.getCachedViews
})

//region 无感刷新
const routerAlive = ref(true)
// 无感刷新，防止出现页面闪烁白屏
const reload = () => {
  routerAlive.value = false
  nextTick(() => (routerAlive.value = true))
}
// 为组件后代提供刷新方法
provide('reload', reload)
//endregion
</script>

<template>
  <section
    :class="[
      'w-full bg-[var(--app-content-bg-color)] dark:bg-[var(--el-bg-color)]',
      isFullScreenPage ? 'p-0 !bg-[#04060d]' : 'p-[var(--app-content-padding)]',
      {
        '!min-h-[calc(100vh-var(--top-tool-height)-var(--tags-view-height)-var(--app-footer-height))] pb-0':
          footer
      }
    ]"
  >
    <router-view v-if="routerAlive">
      <template #default="{ Component, route }">
        <keep-alive :include="getCaches">
          <component :is="Component" :key="route.fullPath" />
        </keep-alive>
      </template>
    </router-view>
  </section>
  <Footer v-if="footer" />
</template>
