#!/bin/bash

# Skedio Frontend Setup Script
# This script initializes the Skedio frontend development environment

set -e

echo "🚀 Skedio Frontend Setup"
echo "========================="
echo ""

# Check prerequisites
echo "✓ Checking prerequisites..."

if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js >= 18.0.0"
    exit 1
fi

echo "  ✓ Node.js: $(node --version)"

if ! command -v npm &> /dev/null && ! command -v bun &> /dev/null; then
    echo "❌ Neither npm nor bun found. Please install one of them."
    exit 1
fi

if command -v bun &> /dev/null; then
    PKG_MANAGER="bun"
    echo "  ✓ Using Bun: $(bun --version)"
else
    PKG_MANAGER="npm"
    echo "  ✓ Using npm: $(npm --version)"
fi

echo ""
echo "📦 Installing dependencies..."

if [ "$PKG_MANAGER" = "bun" ]; then
    bun install
else
    npm install
fi

echo ""
echo "✨ Creating environment file..."

if [ ! -f .env.local ]; then
    cat > .env.local << 'EOF'
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url_here
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key_here

# API Configuration
NEXT_PUBLIC_API_URL=http://localhost:8080
NEXT_PUBLIC_VALIDATION_KEY=your_validation_key_64_chars

# App Configuration  
NEXT_PUBLIC_APP_ENV=development
NODE_ENV=development
EOF
    echo "  ✓ Created .env.local (update with your Supabase credentials)"
else
    echo "  ✓ .env.local already exists"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Update .env.local with your Supabase credentials"
echo "2. Run 'bun run dev' (or 'npm run dev') to start development"
echo "3. Visit http://localhost:3000 in your browser"
echo ""
echo "Happy coding! 🎉"
