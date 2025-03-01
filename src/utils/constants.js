// src/utils/constants.js
export const API_URL = import.meta.env.VITE_API_URL || "http://127.0.0.1:8000/api" //'https://alycisse224.pythonanywhere.com/api'


export const AUTH_ENDPOINTS = {
  USER: `${API_URL}/me`,
  LOGIN: `${API_URL}/login/`,
  REGISTER: `${API_URL}/register`,
  LOGOUT: `${API_URL}/logout`,
  REFRESH_TOKEN: `${API_URL}/refresh`
};

export const STORAGE_KEYS = {
  USER: 'user',
  ACCESS_TOKEN: 'access_token',
  REFRESH_TOKEN: 'refresh_token'
};
