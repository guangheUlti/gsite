<template>
  <div class="gh-home">
    <section class="gh-home__panel">
      <img :src="logo" class="gh-home__logo" alt="光何" draggable="false" />

      <h1 class="gh-home__title">{{ title }}</h1>
      <p class="gh-home__en">{{ enTitle }}</p>

      <div class="gh-home__divider">
        <span class="gh-home__divider-dot"></span>
      </div>

      <p class="gh-home__desc">{{ slogan }}</p>

      <ul class="gh-home__tags">
        <li v-for="tag in tags" :key="tag" class="gh-home__tag">{{ tag }}</li>
      </ul>
    </section>
  </div>
</template>

<script lang="ts" setup>
import logo from '@/assets/imgs/logo.png'

defineOptions({ name: 'Index' })

const { t } = useI18n()

const title = computed(() => t('landing.title'))
const enTitle = computed(() => t('landing.enTitle'))
const slogan = computed(() => t('workplace.slogan'))
const tags = computed(() =>
  ['landing.tag1', 'landing.tag2', 'landing.tag3', 'landing.tag4'].map((key) => t(key))
)
</script>

<style lang="scss" scoped>
.gh-home {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: calc(
    100vh - var(--top-tool-height) - var(--tags-view-height) - var(--app-footer-height) - 2 *
      var(--app-content-padding)
  );
  padding: 8px 0;

  &__panel {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    max-width: 880px;
    text-align: center;
  }

  /* logo 图片自带透明留白（上下约 10% / 14%），盒子 92px 时可见图形约 70px */
  &__logo {
    width: 92px;
    height: 92px;
    margin-bottom: 6px;
    filter: drop-shadow(0 6px 16px rgb(0 0 0 / 14%));
    user-select: none;
  }

  &__title {
    margin: 0;
    font-size: 48px;
    font-weight: 700;
    line-height: 1.2;
    letter-spacing: 0.12em;
    color: var(--el-text-color-primary);
  }

  &__en {
    margin: 14px 0 0;
    font-size: 13px;
    font-weight: 500;
    letter-spacing: 0.38em;
    color: var(--el-text-color-secondary);
    text-transform: uppercase;
  }

  &__divider {
    position: relative;
    width: 190px;
    height: 1px;
    margin: 26px 0 24px;
    background: linear-gradient(90deg, transparent, var(--el-color-primary) 50%, transparent);

    &-dot {
      position: absolute;
      top: -2px;
      left: 50%;
      width: 5px;
      height: 5px;
      margin-left: -2.5px;
      background: var(--el-color-primary);
      border-radius: 50%;
    }
  }

  &__desc {
    margin: 0;
    font-size: 18px;
    letter-spacing: 0.18em;
    color: var(--el-text-color-regular);
  }

  &__tags {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 14px;
    padding: 0;
    margin: 34px 0 0;
    list-style: none;
  }

  &__tag {
    padding: 8px 22px;
    font-size: 14px;
    letter-spacing: 0.14em;
    color: var(--el-text-color-regular);
    background: var(--el-fill-color-light);
    border: 1px solid var(--el-border-color);
    border-radius: 999px;
    transition:
      color 0.25s ease,
      border-color 0.25s ease,
      background 0.25s ease;

    &:hover {
      color: var(--el-color-primary);
      background: var(--el-color-primary-light-9);
      border-color: var(--el-color-primary);
    }
  }
}

@media (width <= 768px) {
  .gh-home {
    &__title {
      font-size: 32px;
      letter-spacing: 0.08em;
    }

    &__logo {
      width: 68px;
      height: 68px;
    }

    &__en {
      font-size: 11px;
      letter-spacing: 0.28em;
    }

    &__desc {
      font-size: 15px;
      letter-spacing: 0.12em;
    }
  }
}
</style>
