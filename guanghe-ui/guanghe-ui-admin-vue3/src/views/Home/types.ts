export type WorkplaceTotal = {
  user: number
  role: number
  dept: number
  menu: number
}

export type Project = {
  name: string
  icon: string
  message: string
  personal: string
  time: Date | number | string
  color: string
}

export type Shortcut = {
  name: string
  icon: string
  url: string
  color: string
}

export type RadarData = {
  personal: number
  team: number
  max: number
  name: string
}
export type AnalysisTotalTypes = {
  users: number
  messages: number
  moneys: number
  shoppings: number
}

export type UserAccessSource = {
  value: number
  name: string
}

export type WeeklyUserActivity = {
  value: number
  name: string
}

export type MonthlySales = {
  name: string
  estimate: number
  actual: number
}
