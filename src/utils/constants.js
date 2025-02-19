// src/utils/constants.js
export const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8080/api';

export const AUTH_ENDPOINTS = {
  LOGIN: `${API_URL}/login`,
  REGISTER: `${API_URL}/register`,
  LOGOUT: `${API_URL}/auth/signout`,
  REFRESH_TOKEN: `${API_URL}/refreshtoken`
};

export const STORAGE_KEYS = {
  USER: 'user',
  ACCESS_TOKEN: 'access_token',
  REFRESH_TOKEN: 'refresh_token'
};
