import request from '@/config/axios'

export interface SystemUpdateUploadRespVO {
  tempFilePath: string
  fileName: string
  fileSize: number
  type: string
  validationInfo: string
}

export interface BackupInfo {
  timestamp: string
  type: string
  description: string
}

export interface SystemUpdateStatusVO {
  updating: boolean
  progressMessage: string
  lastUpdateTime: string | null
  lastUpdateResult: string | null
  currentBackendJar: string | null
  backups: BackupInfo[]
}

// 上传更新包（自定义上传，不走通用 /infra/file/upload）
export const uploadUpdatePackage = (data: { file: File; type: string }, onUploadProgress?: (progressEvent: any) => void) => {
  const formData = new FormData()
  formData.append('file', data.file)
  formData.append('type', data.type)
  return request.upload({
    url: '/infra/system-update/upload',
    data: formData,
    onUploadProgress
  })
}

// 应用更新
export const applyUpdate = (params: { backendTempPath?: string; frontendTempPath?: string }) => {
  return request.post({ url: '/infra/system-update/apply', params })
}

// 回滚
export const rollbackUpdate = (params: { backupTimestamp: string }) => {
  return request.post({ url: '/infra/system-update/rollback', params })
}

// 获取状态
export const getUpdateStatus = (): Promise<SystemUpdateStatusVO> => {
  return request.get({ url: '/infra/system-update/status' })
}
