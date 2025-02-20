// src/utils/constants.js
export const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8080/api';

export const AUTH_ENDPOINTS = {
  LOGIN: \`\${API_URL}/auth/signin\`,
  REGISTER: \`\${API_URL}/auth/signup\`,
  LOGOUT: \`\${API_URL}/auth/signout\`,
  REFRESH_TOKEN: \`\${API_URL}/auth/refreshtoken\`
};

export const STORAGE_KEYS = {
  USER: 'user',
  ACCESS_TOKEN: 'access_token',
  REFRESH_TOKEN: 'refresh_token'
};
