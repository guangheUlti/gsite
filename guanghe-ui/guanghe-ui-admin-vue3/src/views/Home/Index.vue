<template>
  <div ref="heroRef" class="gh-hero">
    <canvas ref="canvasRef" class="gh-hero__canvas"></canvas>
    <div class="gh-hero__grid"></div>
    <div class="gh-hero__aura gh-hero__aura--brand"></div>
    <div class="gh-hero__aura gh-hero__aura--cyan"></div>
    <div class="gh-hero__scan"></div>

    <div class="gh-hero__hud gh-hero__hud--left">
      <span class="gh-hero__hud-dot"></span>
      <span>{{ hudLeft }}</span>
    </div>
    <div class="gh-hero__hud gh-hero__hud--right">
      <span class="gh-hero__hud-dot"></span>
      <span>{{ hudRight }}</span>
    </div>

    <div class="gh-hero__content">
      <div class="gh-hero__emblem">
        <div class="gh-hero__ring gh-hero__ring--outer"></div>
        <div class="gh-hero__ring gh-hero__ring--inner"></div>
        <div class="gh-hero__glow"></div>
        <img :src="logo" class="gh-hero__logo" alt="光何" draggable="false" />
      </div>

      <h1 class="gh-hero__title">{{ title }}</h1>
      <p class="gh-hero__en">{{ enTitle }}</p>

      <div class="gh-hero__divider">
        <span class="gh-hero__divider-dot"></span>
      </div>

      <p class="gh-hero__desc">{{ slogan }}</p>

      <ul class="gh-hero__tags">
        <li v-for="(tag, i) in tags" :key="tag" class="gh-hero__tag" :style="{ '--delay': `${i * 0.12}s` }">
          {{ tag }}
        </li>
      </ul>
    </div>

    <div class="gh-hero__baseline"></div>
  </div>
</template>

<script lang="ts" setup>
import logo from '@/assets/imgs/logo.png'
import { useAppStore } from '@/store/modules/app'

defineOptions({ name: 'Index' })

const { t } = useI18n()

const title = computed(() => t('landing.title'))
const enTitle = computed(() => t('landing.enTitle'))
const slogan = computed(() => t('workplace.slogan'))
const hudLeft = computed(() => t('landing.hudLeft'))
const hudRight = computed(() => t('landing.hudRight'))
const tags = computed(() => ['landing.tag1', 'landing.tag2', 'landing.tag3', 'landing.tag4'].map((key) => t(key)))

// #region 铺满内容区：高度按“内容区顶部 → 视口底部”实测值设置，自动适应 footer、标签栏和侧边栏折叠
const appStore = useAppStore()
const heroRef = ref<HTMLElement | null>(null)
let layoutObserver: ResizeObserver | null = null

const fitToViewport = () => {
  const el = heroRef.value
  const section = el?.parentElement
  if (!el || !section) return
  const paddingBottom = Number.parseFloat(getComputedStyle(section).paddingBottom) || 0
  const footer = section.nextElementSibling as HTMLElement | null
  const footerHeight = footer ? footer.getBoundingClientRect().height : 0
  const available = window.innerHeight - el.getBoundingClientRect().top - footerHeight - paddingBottom
  el.style.height = `${Math.max(320, Math.round(available))}px`
}

onMounted(() => {
  fitToViewport()
  window.addEventListener('resize', fitToViewport)
  const section = heroRef.value?.parentElement
  if (section && typeof ResizeObserver !== 'undefined') {
    layoutObserver = new ResizeObserver(fitToViewport)
    layoutObserver.observe(section)
  }
})

// 标签栏 / 页脚 / 菜单折叠变化后，可用高度会变，重算一次
watch(
  () => [appStore.getTagsView, appStore.getFooter, appStore.getCollapse],
  () => nextTick(fitToViewport),
  { flush: 'post' }
)

onActivated(() => nextTick(fitToViewport))

onBeforeUnmount(() => {
  window.removeEventListener('resize', fitToViewport)
  layoutObserver?.disconnect()
  layoutObserver = null
})
// #endregion

// #region 粒子背景：纯 canvas 绘制，无第三方依赖
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
    const count = Math.min(64, Math.max(20, Math.round((width * height) / 24000)))
    particles = Array.from({ length: count }, () => ({
      x: Math.random() * width,
      y: Math.random() * height,
      vx: (Math.random() - 0.5) * 0.22,
      vy: (Math.random() - 0.5) * 0.22
    }))
  }

  const linkDistance = 130
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
        const alpha = (1 - distSq / linkDistanceSq) * 0.26
        ctx.strokeStyle = `rgba(126, 202, 255, ${alpha.toFixed(3)})`
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
      ctx.fillStyle = 'rgba(158, 224, 255, 0.55)'
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
})
// #endregion
</script>

<style lang="scss" scoped>
.gh-hero {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  /* 铺满整个 tab 内容区：首页的内容区已被 AppView 置为 p-0 且不渲染页脚，高度由 fitToViewport 实测设置 */
  width: 100%;
  height: calc(100vh - var(--top-tool-height) - var(--tags-view-height));
  padding: 72px 32px;
  border-radius: 0;
  background:
    radial-gradient(120% 90% at 50% -20%, #122046 0%, transparent 55%),
    radial-gradient(90% 70% at 85% 105%, #1a1230 0%, transparent 60%),
    linear-gradient(165deg, #070b16 0%, #050813 45%, #04060d 100%);
  box-shadow: inset 0 1px 0 rgb(255 255 255 / 6%);
  isolation: isolate;

  &__canvas,
  &__grid,
  &__aura,
  &__scan,
  &__baseline {
    position: absolute;
    pointer-events: none;
  }

  &__canvas {
    inset: 0;
    width: 100%;
    height: 100%;
    opacity: 0.85;
  }

  &__grid {
    inset: -10%;
    background-image:
      linear-gradient(to right, rgb(120 190 255 / 7%) 1px, transparent 1px),
      linear-gradient(to bottom, rgb(120 190 255 / 7%) 1px, transparent 1px);
    background-size: 54px 54px;
    mask-image: radial-gradient(circle at 50% 45%, #000 0%, #000 32%, transparent 72%);
    -webkit-mask-image: radial-gradient(circle at 50% 45%, #000 0%, #000 32%, transparent 72%);
    animation: gh-grid-drift 24s linear infinite;
  }

  &__aura {
    border-radius: 50%;
    filter: blur(80px);
    mix-blend-mode: screen;

    &--brand {
      top: -190px;
      left: 50%;
      width: 560px;
      height: 380px;
      margin-left: -280px;
      background: radial-gradient(circle, rgb(255 118 48 / 62%), rgb(255 90 30 / 12%) 55%, transparent 72%);
      animation: gh-breathe 9s ease-in-out infinite;
    }

    &--cyan {
      right: -180px;
      bottom: -220px;
      width: 600px;
      height: 480px;
      background: radial-gradient(circle, rgb(46 170 255 / 40%), transparent 68%);
      animation: gh-breathe 11s ease-in-out infinite reverse;
    }
  }

  &__scan {
    top: 0;
    left: 0;
    width: 100%;
    height: 26%;
    background: linear-gradient(180deg, transparent 0%, rgb(120 200 255 / 5%) 45%, rgb(120 200 255 / 9%) 72%, transparent 100%);
    animation: gh-scan 8s ease-in-out infinite;
  }

  &__baseline {
    right: 12%;
    bottom: 0;
    left: 12%;
    height: 1px;
    background: linear-gradient(90deg, transparent, rgb(130 200 255 / 35%), rgb(255 140 80 / 45%), transparent);
  }

  &__hud {
    position: absolute;
    top: 26px;
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 11px;
    font-weight: 500;
    letter-spacing: 0.18em;
    color: rgb(159 199 240 / 62%);
    text-transform: uppercase;

    &--left {
      left: 30px;
    }

    &--right {
      right: 30px;
    }
  }

  &__hud-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    background: #45e0c0;
    box-shadow: 0 0 10px #45e0c0;
    animation: gh-pulse 2.2s ease-in-out infinite;
  }

  &__content {
    position: relative;
    z-index: 2;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
  }

  &__emblem {
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 148px;
    height: 148px;
    margin-bottom: 26px;
  }

  &__ring {
    position: absolute;
    border-radius: 50%;

    &--outer {
      inset: 0;
      background: conic-gradient(
        from 0deg,
        transparent 0deg,
        rgb(255 122 58 / 85%) 40deg,
        transparent 110deg,
        transparent 250deg,
        rgb(86 205 255 / 70%) 300deg,
        transparent 350deg
      );
      mask: radial-gradient(farthest-side, transparent calc(100% - 1.5px), #000 calc(100% - 1.5px));
      -webkit-mask: radial-gradient(farthest-side, transparent calc(100% - 1.5px), #000 calc(100% - 1.5px));
      animation: gh-spin 9s linear infinite;
    }

    &--inner {
      inset: 14px;
      border: 1px solid rgb(140 200 255 / 16%);
      box-shadow: inset 0 0 24px rgb(90 170 255 / 12%);
    }
  }

  &__glow {
    position: absolute;
    inset: 22px;
    border-radius: 50%;
    background: radial-gradient(circle, rgb(255 120 60 / 26%), transparent 70%);
    filter: blur(12px);
  }

  &__logo {
    position: relative;
    width: 82px;
    height: 82px;
    user-select: none;
    filter: drop-shadow(0 8px 22px rgb(255 110 50 / 45%));
  }

  &__title {
    margin: 0;
    font-size: 52px;
    font-weight: 700;
    line-height: 1.15;
    letter-spacing: 0.14em;
    background: linear-gradient(180deg, #fff 0%, #dbe9ff 52%, #9fc4ee 100%);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    text-shadow: 0 0 46px rgb(120 180 255 / 22%);
  }

  &__en {
    margin: 14px 0 0;
    font-size: 12px;
    font-weight: 500;
    letter-spacing: 0.42em;
    color: rgb(150 190 235 / 68%);
    text-transform: uppercase;
  }

  &__divider {
    position: relative;
    width: 220px;
    height: 1px;
    margin: 30px 0 26px;
    background: linear-gradient(90deg, transparent, rgb(255 140 80 / 55%) 50%, transparent);

    &-dot {
      position: absolute;
      top: -2px;
      left: 50%;
      width: 5px;
      height: 5px;
      margin-left: -2.5px;
      border-radius: 50%;
      background: #ff8a45;
      box-shadow: 0 0 12px 2px rgb(255 120 60 / 70%);
    }
  }

  &__desc {
    margin: 0;
    font-size: 16px;
    font-weight: 300;
    letter-spacing: 0.22em;
    color: rgb(214 229 247 / 82%);
  }

  &__tags {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 12px;
    margin: 40px 0 0;
    padding: 0;
    list-style: none;
  }

  &__tag {
    padding: 7px 18px;
    font-size: 12px;
    letter-spacing: 0.16em;
    color: rgb(206 226 249 / 80%);
    border: 1px solid rgb(140 195 255 / 18%);
    border-radius: 999px;
    background: rgb(125 180 255 / 6%);
    backdrop-filter: blur(6px);
    animation: gh-fade-up 0.9s cubic-bezier(0.22, 1, 0.36, 1) both;
    animation-delay: calc(0.35s + var(--delay, 0s));
    transition:
      border-color 0.3s ease,
      color 0.3s ease,
      background 0.3s ease;

    &:hover {
      color: #fff;
      border-color: rgb(255 140 80 / 55%);
      background: rgb(255 130 70 / 12%);
    }
  }
}

@keyframes gh-spin {
  to {
    transform: rotate(360deg);
  }
}

@keyframes gh-grid-drift {
  to {
    transform: translate3d(54px, 54px, 0);
  }
}

@keyframes gh-scan {
  0% {
    transform: translateY(-30%);
    opacity: 0;
  }

  25% {
    opacity: 0.85;
  }

  70% {
    opacity: 0.6;
  }

  85%,
  100% {
    transform: translateY(430%);
    opacity: 0;
  }
}

@keyframes gh-breathe {
  0%,
  100% {
    transform: scale(1);
    opacity: 0.42;
  }

  50% {
    transform: scale(1.12);
    opacity: 0.62;
  }
}

@keyframes gh-pulse {
  0%,
  100% {
    opacity: 0.45;
  }

  50% {
    opacity: 1;
  }
}

@keyframes gh-fade-up {
  from {
    opacity: 0;
    transform: translateY(14px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* 视口不够高时收紧间距与尺寸，保证整块面板不出现内部溢出 */
@media (max-height: 820px) {
  .gh-hero {
    padding: 40px 32px;

    &__emblem {
      width: 124px;
      height: 124px;
      margin-bottom: 18px;
    }

    &__logo {
      width: 68px;
      height: 68px;
    }

    &__title {
      font-size: 44px;
    }

    &__en {
      margin-top: 10px;
    }

    &__divider {
      margin: 22px 0 18px;
    }

    &__tags {
      margin-top: 28px;
    }
  }
}

@media (max-height: 640px) {
  .gh-hero {
    padding: 28px 24px;

    &__emblem {
      width: 96px;
      height: 96px;
      margin-bottom: 12px;
    }

    &__logo {
      width: 52px;
      height: 52px;
    }

    &__title {
      font-size: 34px;
    }

    &__divider {
      margin: 16px 0 12px;
    }

    &__desc {
      font-size: 14px;
    }

    &__tags {
      margin-top: 20px;
    }
  }
}

@media (prefers-reduced-motion: reduce) {
  .gh-hero__grid,
  .gh-hero__aura,
  .gh-hero__scan,
  .gh-hero__ring--outer,
  .gh-hero__hud-dot,
  .gh-hero__tag {
    animation: none !important;
  }
}

@media (width <= 768px) {
  .gh-hero {
    padding: 60px 20px;

    &__title {
      font-size: 32px;
      letter-spacing: 0.1em;
    }

    &__en {
      font-size: 10px;
      letter-spacing: 0.28em;
    }

    &__desc {
      font-size: 13px;
      letter-spacing: 0.14em;
    }

    &__hud {
      display: none;
    }
  }
}
</style>
