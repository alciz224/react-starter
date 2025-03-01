// src/services/auth.service.js
import api from './api.service';
import TokenService from './token.service';
import { AUTH_ENDPOINTS } from '../utils/constants';

class AuthService {
  async login(username, password) {
    try {
      const response = await api.post(AUTH_ENDPOINTS.LOGIN, { username, password });
      if (response.data.access) {
        TokenService.setUser(response.data);
      }
      return response.data;
    } catch (error) {
      throw this.handleError(error);
    }
  }

  async logout() {
    try {
      await api.post(AUTH_ENDPOINTS.LOGOUT);
    } catch (error) {
      console.error("Logout error", error);
    } finally {
      TokenService.removeUser();
    }
  }

  async register(username, email, password) {
    try {
      return await api.post(AUTH_ENDPOINTS.REGISTER, { username, email, password });
    } catch (error) {
      throw this.handleError(error);
    }
  }

  handleError(error) {
    const message =
      (error.response && error.response.data && error.response.data.message) ||
      error.message ||
      error.toString();
    return new Error(message);
  }

  getCurrentUser() {
    return TokenService.getUser();
  }

  isLoggedIn() {
    const user = this.getCurrentUser();
    return !!user && !!user.accessToken;
  }
}

export default new AuthService();
