<script lang="ts" setup>
import { PropType } from 'vue'
import { useDesign } from '@/hooks/web/useDesign'

interface SegmentedOption {
  /** 段上显示的文字 */
  label: string
  /** 该段对应的值 */
  value: string | number | boolean
  /** hover 提示，缺省用 label */
  title?: string
}

defineOptions({ name: 'SegmentedSwitch' })

const { getPrefixCls } = useDesign()

const prefixCls = getPrefixCls('segmented-switch')

defineProps({
  modelValue: {
    type: [String, Number, Boolean] as PropType<string | number | boolean>,
    default: ''
  },
  options: {
    type: Array as PropType<SegmentedOption[]>,
    default: () => []
  }
})

const emit = defineEmits(['change', 'update:modelValue'])

const onSelect = (value: SegmentedOption['value']) => {
  emit('update:modelValue', value)
  emit('change', value)
}
</script>

<template>
  <div :class="prefixCls" role="group">
    <button
      v-for="item in options"
      :key="String(item.value)"
      type="button"
      class="item"
      :class="{ 'is-active': item.value === modelValue }"
      :title="item.title || item.label"
      @click="onSelect(item.value)"
    >
      {{ item.label }}
    </button>
  </div>
</template>

<style lang="scss" scoped>
// 通用分段切换：两段等宽、等高，激活段用主题色填充
// 配色可由父级覆盖 CSS 变量，未覆盖时跟随 Element Plus 主题
.v-segmented-switch {
  display: inline-flex;
  flex: 0 0 auto;
  align-items: center;
  justify-content: center;
  height: 26px;
  padding: 2px;
  gap: 2px;
  background: var(--segmented-bg, var(--el-fill-color-light));
  border: 1px solid var(--segmented-border, var(--el-border-color-lighter));
  border-radius: 8px;
  box-sizing: border-box;
  transition:
    border-color 0.2s ease,
    background-color 0.2s ease;

  &:hover {
    border-color: var(--segmented-border-hover, var(--el-border-color));
  }

  .item {
    display: inline-flex;
    flex: 1 1 0;
    align-items: center;
    justify-content: center;
    height: 20px;
    min-width: 34px;
    padding: 0 8px;
    font-size: 12px;
    font-weight: 600;
    line-height: 1;
    color: var(--segmented-color, var(--top-header-text-color, var(--el-text-color-regular)));
    white-space: nowrap;
    cursor: pointer;
    background: transparent;
    border: none;
    border-radius: 6px;
    transition:
      color 0.2s ease,
      background-color 0.2s ease,
      box-shadow 0.2s ease;

    &:hover {
      color: var(--segmented-active-color, var(--el-color-primary));
      background: var(--segmented-item-hover-bg, var(--el-fill-color));
    }

    &.is-active,
    &.is-active:hover {
      color: #fff;
      background: var(--segmented-active-color, var(--el-color-primary));
      box-shadow: 0 2px 6px -2px rgba(var(--el-color-primary-rgb, 64, 158, 255), 0.9);
    }
  }
}
</style>
