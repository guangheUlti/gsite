<template>
  <h2 class="login-form-title">{{ getFormTitle }}</h2>
</template>
<script lang="ts" setup>
import { LoginStateEnum, useLoginState } from './useLogin'

defineOptions({ name: 'LoginFormTitle' })

const { t } = useI18n()

const { getLoginState } = useLoginState()

const getFormTitle = computed(() => {
  const titleObj = {
    [LoginStateEnum.RESET_PASSWORD]: t('sys.login.forgetFormTitle'),
    [LoginStateEnum.LOGIN]: t('sys.login.signInFormTitle'),
    [LoginStateEnum.REGISTER]: t('sys.login.signUpFormTitle'),
    [LoginStateEnum.MOBILE]: t('sys.login.mobileSignInFormTitle'),
    [LoginStateEnum.QR_CODE]: t('sys.login.qrSignInFormTitle'),
    [LoginStateEnum.SSO]: t('sys.login.ssoFormTitle')
  }
  return titleObj[unref(getLoginState)]
})
</script>

<style lang="scss" scoped>
.login-form-title {
  margin: 0 0 6px;
  font-size: 20px;
  font-weight: 600;
  letter-spacing: 0.06em;
  text-align: center;
  color: var(--gh-panel-title, #f2f7ff);
}
</style>
