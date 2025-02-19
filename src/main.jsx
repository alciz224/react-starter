import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.jsx'
import Mapp from './Mapp.jsx'
createRoot(document.getElementById('root')).render(
  <StrictMode>
    <Mapp />
  </StrictMode>,
)
