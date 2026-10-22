<template>
  <div class="flex min-h-[calc(100vh-130px)] flex-col items-center justify-center">
    <img :src="logo" alt="" class="h-160px w-160px select-none lt-sm:h-120px lt-sm:w-120px" draggable="false" />
    <p class="mt-32px text-28px font-500 tracking-wide text-[var(--el-text-color-regular)] lt-sm:text-22px">
      {{ t('workplace.slogan') }}
    </p>
  </div>
</template>

<script lang="ts" setup>
import logo from '@/assets/imgs/logo.png'

defineOptions({ name: 'Index' })

const { t } = useI18n()
</script>
