#!/bin/bash
# Script to create folder tree and empty content files

# Create directories
mkdir -p src/components/auth
mkdir -p src/components/layout
mkdir -p src/components/pages
mkdir -p src/contexts
mkdir -p src/services
mkdir -p src/utils

# Create files in src/components/auth
touch src/components/auth/Login.jsx
touch src/components/auth/Register.jsx
touch src/components/auth/PrivateRoute.jsx

# Create files in src/components/layout
touch src/components/layout/Navbar.jsx
touch src/components/layout/Footer.jsx
touch src/components/layout/pageLayout.jsx

# Create files in src/components/pages
touch src/components/pages/Home.jsx
touch src/components/pages/ProtectedPage.jsx
touch src/components/pages/Profile.jsx

# Create files in src/contexts
touch src/contexts/AuthContext.jsx

# Create files in src/services
touch src/services/auth.service.js
touch src/services/api.service.js
touch src/services/token.service.js

# Create files in src/utils
touch src/utils/setupInterceptors.js
touch src/utils/constants.js

echo "Folder structure and empty content files (including pageLayout.jsx) created successfully!"

