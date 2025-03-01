// src/utils/setupInterceptors.js
import api from '../services/api.service';
import TokenService from '../services/token.service';
import { AUTH_ENDPOINTS } from './constants';

const setupInterceptors = (onUnauthorized) => {
  api.interceptors.request.use(
    (config) => {
      const token = TokenService.getLocalAccessToken();
      if (token) config.headers['Authorization'] = 'Bearer ' + token;
      return config;
    },
    (error) => Promise.reject(error)
  );

  api.interceptors.response.use(
    (res) => res,
    async (err) => {
      const originalConfig = err.config;
      if (originalConfig.url !== AUTH_ENDPOINTS.LOGIN && err.response) {
        if (err.response.status === 401 && !originalConfig._retry) {
          originalConfig._retry = true;
          try {
            const rs = await api.post(AUTH_ENDPOINTS.REFRESH_TOKEN);
            const { access } = rs.data;
            TokenService.updateLocalAccessToken(access);
            return api(originalConfig);
          } catch (_error) {
            if (onUnauthorized) onUnauthorized();
            return Promise.reject(_error);
          }
        }
      }
      return Promise.reject(err);
    }
  );
};

export default setupInterceptors;
