<script lang="ts" setup>
import { useLocaleStore } from '@/store/modules/locale'
import { useLocale } from '@/hooks/web/useLocale'
import { propTypes } from '@/utils/propTypes'
import { useDesign } from '@/hooks/web/useDesign'
import { SegmentedSwitch } from '@/components/SegmentedSwitch'

defineOptions({ name: 'LocaleDropdown' })

const { getPrefixCls } = useDesign()

const prefixCls = getPrefixCls('locale-dropdown')

defineProps({
  color: propTypes.string.def(''),
  // icon：图标 + 下拉；segmented：中/EN 分段切换
  variant: propTypes.string.def('icon')
})

const localeStore = useLocaleStore()

const langMap = computed(() => localeStore.getLocaleMap)

const currentLang = computed(() => localeStore.getCurrentLocale)

const setLang = (lang: LocaleType) => {
  if (lang === unref(currentLang).lang) return
  // 需要重新加载页面让整个语言多初始化
  window.location.reload()
  localeStore.setCurrentLocale({
    lang
  })
  const { changeLocale } = useLocale()
  changeLocale(lang)
}

/** 分段按钮上的短标签，保持两段宽度一致 */
const shortLabel = (lang: string) => (lang === 'en' ? 'EN' : '中')

const langOptions = computed(() =>
  langMap.value.map((item) => ({
    label: shortLabel(item.lang),
    value: item.lang,
    title: item.name
  }))
)

const onLangChange = (value: string | number | boolean) => {
  setLang(String(value) as LocaleType)
}
</script>

<template>
  <SegmentedSwitch
    v-if="variant === 'segmented'"
    :model-value="currentLang.lang"
    :options="langOptions"
    @change="onLangChange"
  />
  <ElDropdown v-else :class="prefixCls" trigger="click" @command="setLang">
    <Icon
      :class="$attrs.class"
      :color="color"
      :size="18"
      class="cursor-pointer !p-0"
      icon="ion:language-sharp"
    />
    <template #dropdown>
      <ElDropdownMenu>
        <ElDropdownItem v-for="item in langMap" :key="item.lang" :command="item.lang">
          {{ item.name }}
        </ElDropdownItem>
      </ElDropdownMenu>
    </template>
  </ElDropdown>
</template>
