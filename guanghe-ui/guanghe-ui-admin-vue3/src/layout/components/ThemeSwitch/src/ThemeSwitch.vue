<script lang="ts" setup>
import { useAppStore } from '@/store/modules/app'
import { useIcon } from '@/hooks/web/useIcon'
import { useDesign } from '@/hooks/web/useDesign'
import { propTypes } from '@/utils/propTypes'
import { SegmentedSwitch } from '@/components/SegmentedSwitch'

defineOptions({ name: 'ThemeSwitch' })

const { t } = useI18n()

const { getPrefixCls } = useDesign()

const prefixCls = getPrefixCls('theme-switch')

defineProps({
  // switch：拨杆开关；segmented：与中英切换同款的分段切换
  variant: propTypes.string.def('switch')
})

const Sun = useIcon({ icon: 'emojione-monotone:sun', color: '#fde047' })

const CrescentMoon = useIcon({ icon: 'emojione-monotone:crescent-moon', color: '#fde047' })

const appStore = useAppStore()

// 初始化获取是否是暗黑主题
const isDark = ref(appStore.getIsDark)

// 设置switch的背景颜色
const blackColor = 'var(--el-color-black)'

const themeChange = (val: string | number | boolean) => {
  const dark = Boolean(val)
  isDark.value = dark
  appStore.setIsDark(dark)
}

const themeOptions = computed(() => [
  { label: t('setting.light'), value: false },
  { label: t('setting.dark'), value: true }
])
</script>

<template>
  <SegmentedSwitch
    v-if="variant === 'segmented'"
    :model-value="isDark"
    :options="themeOptions"
    @change="themeChange"
  />
  <ElSwitch
    v-else
    v-model="isDark"
    :active-color="blackColor"
    :active-icon="Sun"
    :border-color="blackColor"
    :class="prefixCls"
    :inactive-color="blackColor"
    :inactive-icon="CrescentMoon"
    inline-prompt
    @change="themeChange"
  />
</template>
<style lang="scss" scoped>
:deep(.el-switch__core .el-switch__inner .is-icon) {
  overflow: visible;
}
</style>
