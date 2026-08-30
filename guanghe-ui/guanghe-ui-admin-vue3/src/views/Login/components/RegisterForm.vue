<template>
  <el-form
    v-show="getShow"
    ref="formLogin"
    :model="registerData.registerForm"
    :rules="registerRules"
    class="login-form"
    label-position="top"
    label-width="120px"
    size="large"
  >
    <el-row class="mx-[-10px]">
      <el-col :span="24" class="px-10px">
        <el-form-item>
          <LoginFormTitle class="w-full" />
        </el-form-item>
      </el-col>
      <el-col :span="24" class="px-10px">
        <el-form-item v-if="registerData.tenantEnable === 'true'" prop="tenantName">
          <el-input
            v-model="registerData.registerForm.tenantName"
            :placeholder="t('login.tenantname')"
            :prefix-icon="iconHouse"
            link
            type="primary"
            size="large"
          />
        </el-form-item>
      </el-col>
      <el-col :span="24" class="px-10px">
        <el-form-item prop="username">
          <el-input
            v-model="registerData.registerForm.username"
            :placeholder="t('login.username')"
            size="large"
            :prefix-icon="iconAvatar"
          />
        </el-form-item>
      </el-col>
      <el-col :span="24" class="px-10px">
        <el-form-item prop="nickname">
          <el-input
            v-model="registerData.registerForm.nickname"
            placeholder="昵称"
            size="large"
            :prefix-icon="iconAvatar"
          />
        </el-form-item>
      </el-col>
      <el-col :span="24" class="px-10px">
        <el-form-item prop="password">
          <el-input
            v-model="registerData.registerForm.password"
            type="password"
            auto-complete="off"
            :placeholder="t('login.password')"
            size="large"
            :prefix-icon="iconLock"
            show-password
          />
        </el-form-item>
      </el-col>
      <el-col :span="24" class="px-10px">
        <el-form-item prop="confirmPassword">
          <el-input
            v-model="registerData.registerForm.confirmPassword"
            type="password"
            size="large"
            auto-complete="off"
            :placeholder="t('login.checkPassword')"
            :prefix-icon="iconLock"
            show-password
          />
        </el-form-item>
      </el-col>
      <el-col :span="24" class="px-10px">
        <el-form-item>
          <el-button :loading="loginLoading" class="w-full" type="primary" @click="getCode()">
            {{ t('login.register') }}
          </el-button>
        </el-form-item>
      </el-col>
      <Verify
        ref="verify"
        :captchaType="captchaType"
        :imgSize="{ width: '400px', height: '200px' }"
        mode="pop"
        @success="handleRegister"
      />
    </el-row>
    <el-button class="w-full" @click="handleBackLogin()">{{ t('login.hasUser') }}</el-button>
  </el-form>
</template>
<script lang="ts" setup>
import LoginFormTitle from './LoginFormTitle.vue'
import { useIcon } from '@/hooks/web/useIcon'
import * as authUtil from '@/utils/auth'
import * as LoginApi from '@/api/login'
import { LoginStateEnum, useLoginState, useFormValid } from './useLogin'

defineOptions({ name: 'RegisterForm' })

const { t } = useI18n()
const message = useMessage()
const iconHouse = useIcon({ icon: 'ep:house' })
const iconAvatar = useIcon({ icon: 'ep:avatar' })
const iconLock = useIcon({ icon: 'ep:lock' })
const formLogin = ref()
const { validForm } = useFormValid(formLogin)
const { handleBackLogin, getLoginState } = useLoginState()
const loginLoading = ref(false)
const verify = ref()
const captchaType = ref('blockPuzzle') // blockPuzzle 滑块 clickWord 点击文字 pictureWord 文字验证码

const getShow = computed(() => unref(getLoginState) === LoginStateEnum.REGISTER)

const equalToPassword = (_rule, value) => {
  if (registerData.registerForm.password !== value) {
    return Promise.reject(new Error('两次输入的密码不一致'))
  }
  return Promise.resolve()
}

const registerRules = {
  tenantName: [
    { required: true, trigger: 'blur', message: '请输入您所属的租户' },
    { min: 2, max: 20, message: '租户账号长度必须介于 2 和 20 之间', trigger: 'blur' }
  ],
  username: [
    { required: true, trigger: 'blur', message: '请输入您的账号' },
    { min: 4, max: 30, message: '用户账号长度必须介于 4 和 30 之间', trigger: 'blur' }
  ],
  nickname: [
    { required: true, trigger: 'blur', message: '请输入您的昵称' },
    { min: 0, max: 30, message: '昵称长度必须介于 0 和 30 之间', trigger: 'blur' }
  ],
  password: [
    { required: true, trigger: 'blur', message: '请输入您的密码' },
    { min: 5, max: 20, message: '用户密码长度必须介于 5 和 20 之间', trigger: 'blur' },
    { pattern: /^[^<>"'|\\]+$/, message: '不能包含非法字符：< > " \' \\\ |', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, trigger: 'blur', message: '请再次输入您的密码' },
    { required: true, validator: equalToPassword, trigger: 'blur' }
  ]
}

const registerData = reactive({
  isShowPassword: false,
  tenantEnable: import.meta.env.VITE_APP_TENANT_ENABLE,
  registerForm: {
    tenantName: import.meta.env.VITE_APP_DEFAULT_LOGIN_TENANT || '',
    nickname: '',
    tenantId: 0,
    username: '',
    password: '',
    confirmPassword: '',
    captchaVerification: ''
  }
})

// 提交注册
const handleRegister = async (params: any) => {
  // 注册接口始终强制验证码，不受 VITE_APP_CAPTCHA_ENABLE 影响
  registerData.registerForm.captchaVerification = params.captchaVerification

  const data = await validForm()
  if (!data) {
    return
  }

  loginLoading.value = true
  try {
    if (registerData.tenantEnable) {
      await getTenantId()
      registerData.registerForm.tenantId = authUtil.getTenantId()
    }

    await LoginApi.register(registerData.registerForm)

    // 注册只创建待审批账号，不签发 Token：需管理员启用后才能登录
    message.alertSuccess('注册成功，请等待管理员审批通过后登录')
    formLogin.value?.resetFields()
    handleBackLogin()
  } finally {
    loginLoading.value = false
  }
}

// 获取验证码
const getCode = async () => {
  // 注册始终需要先通过滑块验证码，再提交注册请求
  verify.value.show()
}

// 获取租户 ID
const getTenantId = async () => {
  if (registerData.tenantEnable === 'true') {
    const res = await LoginApi.getTenantIdByName(registerData.registerForm.tenantName)
    authUtil.setTenantId(res)
  }
}

// 根据域名，获得租户信息
const getTenantByWebsite = async () => {
  if (registerData.tenantEnable === 'true') {
    const website = location.host
    const res = await LoginApi.getTenantByWebsite(website)
    if (res) {
      registerData.registerForm.tenantName = res.name
      authUtil.setTenantId(res.id)
    }
  }
}

onMounted(() => {
  // getCookie()
  getTenantByWebsite()
})
</script>

<style lang="scss" scoped>
:deep(.anticon) {
  &:hover {
    color: var(--el-color-primary) !important;
  }
}

.login-code {
  float: right;
  width: 100%;
  height: 38px;

  img {
    width: 100%;
    height: auto;
    max-width: 100px;
    vertical-align: middle;
    cursor: pointer;
  }
}
</style>
