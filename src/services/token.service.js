// src/services/token.service.js
import { STORAGE_KEYS } from '../utils/constants';

class TokenService {
  getLocalRefreshToken() {
    const user = JSON.parse(localStorage.getItem(STORAGE_KEYS.USER));
    alert("local refresh token", user);
    return user?.refreshToken;
  }

  getLocalAccessToken() {
    const user = JSON.parse(localStorage.getItem(STORAGE_KEYS.USER));
    alert("access token", user);
    return user?.accessToken;
  }

  updateLocalAccessToken(token) {
    const user = JSON.parse(localStorage.getItem(STORAGE_KEYS.USER));
    user.accessToken = token;
    localStorage.setItem(STORAGE_KEYS.USER, JSON.stringify(user));
    alert("updated token", user);
  }

  getUser() {
    alert("get user", JSON.parse(localStorage.getItem(STORAGE_KEYS.USER)));
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.USER));
  }

  setUser(user) {
    localStorage.setItem(STORAGE_KEYS.USER, JSON.stringify(user));
    alert("set user", JSON.parse(localStorage.getItem(STORAGE_KEYS.USER)));
  }

  removeUser() {
    localStorage.removeItem(STORAGE_KEYS.USER);
  }

  getCookie(name) {
    const match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
    return match ? match[2] : null;
  }
}

export default new TokenService();
