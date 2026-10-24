<template>
  <div class="gh-login">
    <!-- 背景层：粒子网络 / 网格 / 主题色光晕 -->
    <div class="gh-login__bg" aria-hidden="true">
      <canvas ref="canvasRef" class="gh-login__canvas"></canvas>
      <div class="gh-login__grid"></div>
      <div class="gh-login__aura"></div>
    </div>

    <!-- 右上角：默认只有一个竖排三点，主题/语言点开才出现，保持页面简洁 -->
    <header class="gh-login__bar">
      <ElPopover
        v-model:visible="toolsOpen"
        placement="bottom-end"
        trigger="click"
        :teleported="false"
        :show-arrow="false"
        :width="136"
        popper-class="gh-login__pop"
      >
        <template #reference>
          <button
            type="button"
            class="gh-login__kebab"
            :title="t('action.more')"
            :aria-label="t('action.more')"
          >
            <Icon icon="ep:more-filled" :size="18" />
          </button>
        </template>

        <div class="gh-login__tools" @click="toolsOpen = false">
          <ThemeSwitch variant="segmented" />
          <LocaleDropdown variant="segmented" />
        </div>
      </ElPopover>
    </header>

    <!-- 中部：标题 + 登录框，整体垂直水平居中 -->
    <main class="gh-login__main">
      <div class="gh-login__stack">
        <section class="gh-login__intro">
          <div
            class="gh-login__brand"
            :class="{
              'gh-login__brand--latin': isLatinTitle,
              'gh-login__brand--wrap': titleOnMultipleLines
            }"
            :style="{ '--gh-title-size': titleFontSize + 'px' }"
          >
            <img :src="logo" class="gh-login__logo" alt="光何" draggable="false" />
            <h1 class="gh-login__title">{{ title }}</h1>
          </div>

          <div class="gh-login__divider">
            <span class="gh-login__divider-dot"></span>
          </div>
        </section>

        <section class="gh-login__panel">
          <!-- 账号登录 -->
          <LoginForm class="gh-login__form" />
          <!-- 用户注册 -->
          <RegisterForm class="gh-login__form" />
          <!-- 三方登录 -->
          <SSOLoginVue class="gh-login__form" />
        </section>
      </div>
    </main>

    <footer class="gh-login__foot"> Copyright © {{ year }} {{ title }} </footer>
  </div>
</template>

<script lang="ts" setup>
import logo from '@/assets/imgs/logo.png'
import { ThemeSwitch } from '@/layout/components/ThemeSwitch'
import { LocaleDropdown } from '@/layout/components/LocaleDropdown'

import { LoginForm, RegisterForm, SSOLoginVue } from './components'

defineOptions({ name: 'Login' })

const { t } = useI18n()

const title = computed(() => t('landing.title'))
const year = new Date().getFullYear()

// 右上角三点展开的主题/语言面板，选完自动收起
const toolsOpen = ref(false)

// #region 标题自适应：中英文文案长度差异大，按实际文本宽度收缩字号，避免换行撑破布局
const viewport = ref({
  w: typeof window === 'undefined' ? 1440 : window.innerWidth,
  h: typeof window === 'undefined' ? 900 : window.innerHeight
})
const onViewportResize = () => {
  viewport.value = { w: window.innerWidth, h: window.innerHeight }
}

/** CJK / 全角字符按 1em 估宽，其余常见拉丁字符约 0.6em，空格 0.3em */
const CJK_RE = /[\u2e80-\u9fff\uf900-\ufaff\uff00-\uffef]/

const isLatinTitle = computed(() => !CJK_RE.test(title.value || ''))

/** 窄屏时放不下单行，改为折行，换取更可读的字号 */
const titleOnMultipleLines = computed(() => viewport.value.w <= 640)

const titleFontSize = computed(() => {
  const text = title.value || ''
  const { w, h } = viewport.value

  // 上限：沿用原有的视口高度分档
  let max = 46
  if (h <= 680) max = 30
  else if (h <= 820) max = 38
  if (w <= 768) max = Math.min(max, 32)

  // 标题允许比登录面板（420）略宽一点，给英文长文案留出字号空间
  const available = Math.min(w - 48, 460)
  const gap = 16
  const spacing = isLatinTitle.value ? 0.02 : 0.12

  let em = 0
  for (const ch of text) {
    if (ch === ' ') em += 0.3
    else em += CJK_RE.test(ch) ? 1.02 : 0.6
  }
  em += Array.from(text).length * spacing

  // logo 固定 1.5em，加 gap 后必须整体放进可用宽度
  const fitted = (available - gap) / (em + 1.5)
  const size = titleOnMultipleLines.value ? fitted * 1.4 : fitted
  return Math.round(Math.max(18, Math.min(max, size)))
})

onMounted(() => window.addEventListener('resize', onViewportResize))
// #endregion

// #region 粒子网络背景（纯 canvas，颜色跟随系统主题色）
const canvasRef = ref<HTMLCanvasElement | null>(null)
let rafId = 0
let disposed = false
let resizeObserver: ResizeObserver | null = null

interface Particle {
  x: number
  y: number
  vx: number
  vy: number
}

onMounted(() => {
  const canvas = canvasRef.value
  const ctx = canvas?.getContext('2d')
  if (!canvas || !ctx) return

  // 主题色以 "r, g, b" 形式暴露在 --el-color-primary-rgb 上；未初始化时从 --el-color-primary 解析
  const rootStyle = getComputedStyle(document.documentElement)
  const primaryRgb =
    rootStyle.getPropertyValue('--el-color-primary-rgb').trim() ||
    (() => {
      const hex = (rootStyle.getPropertyValue('--el-color-primary').trim() || '#409eff').replace(
        '#',
        ''
      )
      if (!/^[\da-f]{6}$/i.test(hex)) return '64, 158, 255'
      return `${parseInt(hex.slice(0, 2), 16)}, ${parseInt(hex.slice(2, 4), 16)}, ${parseInt(hex.slice(4, 6), 16)}`
    })()

  const reduceMotion = window.matchMedia?.('(prefers-reduced-motion: reduce)')?.matches ?? false
  const dpr = Math.min(window.devicePixelRatio || 1, 2)
  let width = 0
  let height = 0
  let particles: Particle[] = []

  const build = () => {
    const rect = canvas.getBoundingClientRect()
    width = rect.width
    height = rect.height
    canvas.width = Math.max(1, Math.floor(width * dpr))
    canvas.height = Math.max(1, Math.floor(height * dpr))
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0)
    const count = Math.min(72, Math.max(20, Math.round((width * height) / 26000)))
    particles = Array.from({ length: count }, () => ({
      x: Math.random() * width,
      y: Math.random() * height,
      vx: (Math.random() - 0.5) * 0.22,
      vy: (Math.random() - 0.5) * 0.22
    }))
  }

  const linkDistance = 140
  const linkDistanceSq = linkDistance * linkDistance

  const paint = () => {
    ctx.clearRect(0, 0, width, height)

    for (let i = 0; i < particles.length; i++) {
      const a = particles[i]
      for (let j = i + 1; j < particles.length; j++) {
        const b = particles[j]
        const dx = a.x - b.x
        const dy = a.y - b.y
        const distSq = dx * dx + dy * dy
        if (distSq > linkDistanceSq) continue
        const alpha = (1 - distSq / linkDistanceSq) * 0.22
        ctx.strokeStyle = `rgba(${primaryRgb}, ${alpha.toFixed(3)})`
        ctx.lineWidth = 0.6
        ctx.beginPath()
        ctx.moveTo(a.x, a.y)
        ctx.lineTo(b.x, b.y)
        ctx.stroke()
      }
    }

    for (const p of particles) {
      ctx.beginPath()
      ctx.arc(p.x, p.y, 1.2, 0, Math.PI * 2)
      ctx.fillStyle = `rgba(${primaryRgb}, 0.5)`
      ctx.fill()

      p.x += p.vx
      p.y += p.vy
      if (p.x < -20) p.x = width + 20
      if (p.x > width + 20) p.x = -20
      if (p.y < -20) p.y = height + 20
      if (p.y > height + 20) p.y = -20
    }

    if (!disposed && !reduceMotion) rafId = requestAnimationFrame(paint)
  }

  build()
  paint()

  resizeObserver = new ResizeObserver(() => {
    build()
    if (reduceMotion) paint()
  })
  resizeObserver.observe(canvas)
})

onBeforeUnmount(() => {
  disposed = true
  cancelAnimationFrame(rafId)
  resizeObserver?.disconnect()
  resizeObserver = null
  window.removeEventListener('resize', onViewportResize)
})
// #endregion
</script>

<style lang="scss" scoped>
.gh-login {
  /* 主题色 RGB（跟随 --el-color-primary，未初始化时回落到 Element Plus 默认蓝） */
  --gh-rgb: var(--el-color-primary-rgb, 64, 158, 255);

  /* 标题字号：logo 高度与之联动，保证并列时高度一致 */
  --gh-title-size: 46px;

  /* ---------- 亮色（默认）配色令牌，暗色在下方 html.dark 规则里覆盖 ---------- */
  --gh-page-bg:
    radial-gradient(
      120% 90% at 50% -18%,
      color-mix(in srgb, var(--el-color-primary) 16%, transparent) 0%,
      transparent 58%
    ),
    linear-gradient(168deg, #f8fbff 0%, #eef4fd 46%, #e7eefb 100%);
  --gh-grid: color-mix(in srgb, var(--el-color-primary) 10%, transparent);
  --gh-aura: color-mix(in srgb, var(--el-color-primary) 30%, transparent);
  --gh-aura-blend: normal;
  --gh-title-1: #17243a;
  --gh-title-2: #2d4a71;
  --gh-title-3: #5d80a9;
  --gh-title-glow: color-mix(in srgb, var(--el-color-primary) 18%, transparent);
  --gh-sub: rgb(66 100 142 / 78%);
  --gh-tool: rgb(58 92 130 / 85%);
  --gh-panel-bg: linear-gradient(180deg, rgb(255 255 255 / 95%), rgb(246 250 255 / 97%));
  --gh-panel-border: color-mix(in srgb, var(--el-color-primary) 18%, transparent);
  --gh-panel-shadow: 0 30px 70px -32px rgb(30 60 110 / 28%), inset 0 1px 0 #fff;
  --gh-input-bg: rgb(255 255 255 / 92%);
  --gh-input-border: rgb(24 52 88 / 14%);
  --gh-input-focus-bg: #fff;
  --gh-text: #1b2b41;
  --gh-panel-title: #1b2b41;
  --gh-placeholder: rgb(80 110 148 / 55%);
  --gh-icon: rgb(80 112 150 / 62%);
  --gh-label: rgb(52 84 120 / 86%);
  --gh-checkbox-border: rgb(24 52 88 / 26%);
  --gh-plain-btn-text: rgb(44 74 110 / 88%);
  --gh-plain-btn-border: rgb(24 52 88 / 16%);
  --gh-plain-btn-bg: rgb(255 255 255 / 72%);
  --gh-divider: rgb(24 52 88 / 12%);
  --gh-foot: rgb(74 112 156 / 60%);
  --gh-link: var(--el-color-primary);
  --gh-error: #d94a3d;

  position: relative;
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100vh;
  overflow: hidden;
  background: var(--gh-page-bg);
  isolation: isolate;
  transition: background 0.3s ease;

  &__bg {
    position: absolute;
    inset: 0;
    overflow: hidden;
    pointer-events: none;
  }

  &__canvas {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    opacity: 0.7;
  }

  &__grid {
    position: absolute;
    inset: -10%;
    background-image:
      linear-gradient(to right, var(--gh-grid) 1px, transparent 1px),
      linear-gradient(to bottom, var(--gh-grid) 1px, transparent 1px);
    background-size: 56px 56px;
    mask-image: radial-gradient(circle at 50% 42%, #000 0%, #000 30%, transparent 72%);
    -webkit-mask-image: radial-gradient(circle at 50% 42%, #000 0%, #000 30%, transparent 72%);
    animation: gh-login-grid 26s linear infinite;
  }

  &__aura {
    position: absolute;
    top: -230px;
    left: 50%;
    width: 640px;
    height: 420px;
    margin-left: -320px;
    border-radius: 50%;
    background: radial-gradient(circle, var(--gh-aura), transparent 70%);
    filter: blur(90px);
    mix-blend-mode: var(--gh-aura-blend);
    animation: gh-login-breathe 11s ease-in-out infinite;
  }

  /* ---------------- 顶栏 ---------------- */
  &__bar {
    position: relative;
    z-index: 3;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    padding: 22px 30px;
  }

  /* 竖排三点：低调的半透明按钮，hover 才提亮，不抢登录框的视线 */
  &__kebab {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 32px;
    height: 32px;
    padding: 0;
    color: var(--gh-tool);
    cursor: pointer;
    background: transparent;
    border: none;
    border-radius: 10px;
    opacity: 0.55;
    transition:
      opacity 0.2s ease,
      color 0.2s ease,
      background-color 0.2s ease;

    &:hover,
    &:focus-visible {
      color: var(--el-color-primary);
      background: var(--gh-plain-btn-bg);
      opacity: 1;
      outline: none;
    }

    /* Element Plus 的 more 图标是横排三点，转 90° 改成竖排 */
    :deep(.el-icon) {
      transform: rotate(90deg);
    }
  }

  /* 点开后的浮层：两条等宽分段切换上下排 */
  &__tools {
    display: flex;
    flex-direction: column;
    align-items: stretch;
    gap: 8px;

    /* 主题 / 语言两个分段切换：沿用登录页自己的配色令牌 */
    --segmented-bg: var(--gh-plain-btn-bg);
    --segmented-border: var(--gh-input-border);
    --segmented-color: var(--gh-tool);
    --segmented-item-hover-bg: var(--gh-input-bg);

    :deep(.v-segmented-switch) {
      width: 100%;
    }

    :deep(.el-icon) {
      color: var(--gh-tool) !important;
    }

    :deep(.locale-dropdown__trigger) {
      color: var(--gh-tool) !important;
    }
  }

  /* 浮层本体（teleported=false，仍继承本页令牌） */
  :deep(.gh-login__pop.el-popover.el-popper) {
    box-sizing: border-box;
    padding: 8px;
    background: var(--gh-panel-bg);
    border: 1px solid var(--gh-panel-border);
    border-radius: 12px;
    box-shadow: var(--gh-panel-shadow);
  }

  /* ---------------- 中部 ---------------- */
  &__main {
    position: relative;
    z-index: 2;
    display: flex;
    flex: 1 1 auto;
    align-items: center;
    justify-content: center;
    min-height: 0;
    padding: 0 24px 24px;
    overflow: hidden auto;
  }

  &__stack {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    max-width: 420px;
  }

  &__intro {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    animation: gh-login-fade-up 0.8s cubic-bezier(0.22, 1, 0.36, 1) both;
  }

  /* logo + 标题：整体水平居中，logo 在标题左侧，两者下边缘对齐 */
  &__brand {
    display: flex;
    align-items: flex-end;
    justify-content: center;
    gap: 16px;
    max-width: 100%;

    /* 拉丁文案字面更宽，收紧字距，避免标题占满一行后被挤到多行 */
    &--latin .gh-login__title {
      letter-spacing: 0.02em;
    }

    /* 窄屏：允许标题折行，logo 改为垂直居中 */
    &--wrap {
      align-items: center;

      .gh-login__title {
        max-width: 100%;
        line-height: 1.2;
        text-align: center;
        text-wrap: balance;
        white-space: normal;
      }
    }
  }

  /* logo 图片自带透明留白（上 10% / 下 14%），盒子放到 1.5em 后可见图形约 1.14em，比标题字形略大；
     上下负 margin 一进一出：既把图中图形位置校正到与文字底边对齐，又让行高仍等于标题行高 */
  &__logo {
    /* 相对原位置再向下微调 2px（不影响布局） */
    position: relative;
    top: 2px;
    flex-shrink: 0;
    width: calc(var(--gh-title-size) * 1.5);
    height: calc(var(--gh-title-size) * 1.5);
    margin-top: calc(var(--gh-title-size) * -0.172);
    margin-bottom: calc(var(--gh-title-size) * -0.178);
    filter: drop-shadow(0 4px 12px color-mix(in srgb, var(--el-color-primary) 30%, transparent));
    user-select: none;
  }

  &__title {
    margin: 0;
    font-size: var(--gh-title-size);
    font-weight: 700;
    line-height: 1.15;
    letter-spacing: 0.12em;
    white-space: nowrap;
    background: linear-gradient(
      180deg,
      var(--gh-title-1) 0%,
      var(--gh-title-2) 55%,
      var(--gh-title-3) 100%
    );
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    text-shadow: 0 0 46px var(--gh-title-glow);
  }

  &__divider {
    position: relative;
    width: 148px;
    height: 1px;
    margin: 16px 0 0;
    background: linear-gradient(90deg, transparent, rgba(var(--gh-rgb), 0.7) 50%, transparent);

    &-dot {
      position: absolute;
      top: -2px;
      left: 50%;
      width: 5px;
      height: 5px;
      margin-left: -2.5px;
      border-radius: 50%;
      background: var(--el-color-primary);
      box-shadow: 0 0 12px 2px rgba(var(--gh-rgb), 0.65);
    }
  }

  /* ---------------- 登录面板 ---------------- */
  &__panel {
    position: relative;
    width: 100%;

    /* 上内边距 = 下内边距(6px) + 最后一行表单的 16px 外边距，保证上下留白一致 */
    padding: 22px 30px 6px;
    margin-top: 26px;
    border: 1px solid var(--gh-panel-border);
    border-radius: 18px;
    background: var(--gh-panel-bg);
    box-shadow: var(--gh-panel-shadow);
    backdrop-filter: blur(18px);
    transition:
      background 0.3s ease,
      border-color 0.3s ease,
      box-shadow 0.3s ease;
    animation: gh-login-fade-up 0.9s cubic-bezier(0.22, 1, 0.36, 1) 0.1s both;

    /* 顶部主题色高光强调线 */
    &::before {
      position: absolute;
      top: -1px;
      right: 30px;
      left: 30px;
      height: 1px;
      background: linear-gradient(90deg, transparent, rgba(var(--gh-rgb), 0.8) 50%, transparent);
      content: '';
      pointer-events: none;
    }
  }

  /* ---------------- 表单暗色化（强调色一律走系统主题色） ---------------- */
  &__form {
    width: 100%;

    :deep(.el-form-item) {
      margin-bottom: 16px;
    }

    :deep(.el-form-item__label) {
      color: var(--gh-label);
    }

    :deep(.el-input__wrapper) {
      padding: 3px 12px;
      background: var(--gh-input-bg);
      border-radius: 10px;
      box-shadow: 0 0 0 1px var(--gh-input-border) inset;
      transition:
        box-shadow 0.25s ease,
        background 0.25s ease;
    }

    :deep(.el-input__wrapper:hover) {
      box-shadow: 0 0 0 1px rgba(var(--gh-rgb), 0.4) inset;
    }

    :deep(.el-input__wrapper.is-focus) {
      background: var(--gh-input-focus-bg);
      box-shadow:
        0 0 0 1px var(--el-color-primary) inset,
        0 0 20px rgba(var(--gh-rgb), 0.18);
    }

    :deep(.el-input__inner) {
      height: 38px;
      color: var(--gh-text);

      &::placeholder {
        color: var(--gh-placeholder);
      }
    }

    :deep(.el-input__prefix),
    :deep(.el-input__suffix) {
      color: var(--gh-icon);
    }

    :deep(.el-checkbox__label) {
      color: var(--gh-label);
    }

    :deep(.el-checkbox__inner) {
      background: var(--gh-input-bg);
      border-color: var(--gh-checkbox-border);
    }

    :deep(.el-checkbox__input.is-checked .el-checkbox__inner) {
      background: var(--el-color-primary);
      border-color: var(--el-color-primary);
    }

    :deep(.el-button) {
      height: 42px;
      border-radius: 10px;
      font-size: 15px;
      letter-spacing: 0.24em;
    }

    :deep(.el-button--primary) {
      background-image: linear-gradient(
        135deg,
        var(--el-color-primary) 0%,
        var(--el-color-primary-dark-2, var(--el-color-primary)) 100%
      );
      border: none;
      box-shadow: 0 12px 30px -12px rgba(var(--gh-rgb), 0.75);
      transition:
        transform 0.2s ease,
        box-shadow 0.2s ease,
        filter 0.2s ease;

      &:hover {
        transform: translateY(-1px);
        box-shadow: 0 16px 34px -12px rgba(var(--gh-rgb), 0.85);
        filter: brightness(1.05);
      }

      &:active {
        transform: translateY(0);
      }
    }

    :deep(.el-button:not(.el-button--primary)) {
      color: var(--gh-plain-btn-text);
      border-color: var(--gh-plain-btn-border);
      background: var(--gh-plain-btn-bg);
    }

    :deep(.el-link) {
      color: var(--gh-link);

      &:hover {
        color: var(--gh-link);
        filter: brightness(1.12);
      }
    }

    :deep(.el-form-item__error) {
      color: var(--gh-error);
      padding-top: 4px;
    }

    :deep(.el-divider) {
      border-color: var(--gh-divider);
    }

    :deep(.el-divider__text) {
      color: var(--gh-sub);
      background: transparent;
    }

    :deep(.el-tabs__item) {
      color: var(--gh-label);
    }

    :deep(.el-tabs__item.is-active) {
      color: var(--el-color-primary);
    }

    :deep(.el-tabs__nav-wrap::after) {
      background-color: var(--gh-divider);
    }

    :deep(.el-tabs__active-bar) {
      background-color: var(--el-color-primary);
    }
  }

  /* ---------------- 页脚 ---------------- */
  &__foot {
    position: relative;
    z-index: 2;
    padding: 14px 24px 18px;
    font-size: 10px;
    letter-spacing: 0.14em;
    text-align: center;
    color: var(--gh-foot);
  }
}

/* ---------- 暗色（Element Plus 暗色模式挂在 html.dark 上） ---------- */
html.dark .gh-login {
  --gh-page-bg:
    radial-gradient(
      120% 90% at 50% -18%,
      color-mix(in srgb, var(--el-color-primary) 22%, transparent) 0%,
      transparent 58%
    ),
    linear-gradient(168deg, #0a1020 0%, #070c17 46%, #05080f 100%);
  --gh-grid: color-mix(in srgb, var(--el-color-primary) 8%, transparent);
  --gh-aura: color-mix(in srgb, var(--el-color-primary) 42%, transparent);
  --gh-aura-blend: screen;
  --gh-title-1: #fff;
  --gh-title-2: #dfeaff;
  --gh-title-3: #a9c6ec;
  --gh-title-glow: color-mix(in srgb, var(--el-color-primary) 30%, transparent);
  --gh-sub: rgb(158 192 232 / 62%);
  --gh-tool: rgb(190 216 245 / 78%);
  --gh-panel-bg: linear-gradient(180deg, rgb(14 23 41 / 88%), rgb(8 14 26 / 92%));
  --gh-panel-border: color-mix(in srgb, var(--el-color-primary) 16%, transparent);
  --gh-panel-shadow: 0 34px 90px -34px rgb(0 0 0 / 85%), inset 0 1px 0 rgb(255 255 255 / 6%);
  --gh-input-bg: rgb(255 255 255 / 4%);
  --gh-input-border: rgb(255 255 255 / 10%);
  --gh-input-focus-bg: rgb(255 255 255 / 6%);
  --gh-text: #eaf2ff;
  --gh-panel-title: #f2f7ff;
  --gh-placeholder: rgb(150 180 215 / 52%);
  --gh-icon: rgb(150 190 235 / 58%);
  --gh-label: rgb(196 216 240 / 80%);
  --gh-checkbox-border: rgb(255 255 255 / 22%);
  --gh-plain-btn-text: rgb(206 224 246 / 88%);
  --gh-plain-btn-border: rgb(255 255 255 / 16%);
  --gh-plain-btn-bg: rgb(255 255 255 / 3%);
  --gh-divider: rgb(255 255 255 / 12%);
  --gh-foot: rgb(140 180 225 / 42%);
  --gh-link: var(--el-color-primary);
  --gh-error: #ff8f7a;
}

@keyframes gh-login-grid {
  to {
    transform: translate3d(56px, 56px, 0);
  }
}

@keyframes gh-login-breathe {
  0%,
  100% {
    transform: scale(1);
    opacity: 0.34;
  }

  50% {
    transform: scale(1.08);
    opacity: 0.55;
  }
}

@keyframes gh-login-fade-up {
  from {
    opacity: 0;
    transform: translateY(14px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 视口偏矮时收紧，保证标题 + 登录框完整可见 */
@media (max-height: 820px) {
  .gh-login {
    --gh-title-size: 38px;

    &__divider {
      margin-top: 12px;
    }

    &__panel {
      margin-top: 18px;
    }
  }
}

@media (max-height: 680px) {
  .gh-login {
    --gh-title-size: 30px;

    &__title {
      letter-spacing: 0.08em;
    }

    &__divider {
      margin-top: 10px;
    }

    &__panel {
      /* 同样保持上下留白一致：2px + 16px = 18px */
      padding: 18px 22px 2px;
      margin-top: 14px;
    }

    &__bar {
      padding: 14px 20px;
    }

    &__foot {
      padding: 10px 20px 12px;
    }
  }
}

@media (prefers-reduced-motion: reduce) {
  .gh-login__grid,
  .gh-login__aura,
  .gh-login__intro,
  .gh-login__panel {
    animation: none !important;
  }
}

@media (width <= 768px) {
  .gh-login {
    --gh-title-size: 32px;

    &__bar {
      padding: 14px 18px;
    }

    &__main {
      padding: 0 16px 18px;
    }

    &__title {
      letter-spacing: 0.08em;
    }

    &__panel {
      padding: 18px 20px 2px;
      border-radius: 16px;
    }

    &__foot {
      padding: 10px 18px 14px;
    }
  }
}
</style>
