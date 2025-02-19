// src/contexts/AuthContext.jsx
import React, { createContext, useState, useEffect, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import AuthService from '../services/auth.service';
import setupInterceptors from '../utils/setupInterceptors';

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [currentUser, setCurrentUser] = useState(undefined);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  const logOut = async () => {
    await AuthService.logout();
    setCurrentUser(undefined);
  };

  useEffect(() => {
    setupInterceptors(() => {
      logOut();
      navigate('/login', { replace: true });
    });

    const user = AuthService.getCurrentUser();
    if (user) {
      setCurrentUser(user);
    }
    setLoading(false);
  }, [navigate]);

  const logIn = async (username, password) => {
    const userData = await AuthService.login(username, password);
    alert("ok");
    setCurrentUser(userData);
    return userData;
  };

  const register = async (username, email, password) => {
    return await AuthService.register(username, email, password);
  };

  const value = {
    currentUser,
    isLoggedIn: !!currentUser,
    loading,
    logIn,
    logOut,
    register
  };

  return (
    <AuthContext.Provider value={value}>
      {!loading && children}
    </AuthContext.Provider>
  );
};

//export const useAuth = () => useContext(AuthContext);
