#!/bin/bash
set -e

echo "🚀 Setting up Real-Time Drowsiness Detection on macOS..."

# Step 1: Check Homebrew
if ! command -v brew &> /dev/null
then
    echo "❌ Homebrew not found. Please install it first: https://brew.sh/"
    exit 1
fi

# Step 2: Install system dependencies
echo "📦 Installing system dependencies (cmake, boost)..."
brew install cmake boost || true

# Step 3: Create virtual environment if not exists
if [ ! -d "test_env" ]; then
    echo "🐍 Creating Python virtual environment..."
    python3 -m venv test_env
fi

# Step 4: Activate virtual environment
echo "✅ Activating virtual environment..."
source test_env/bin/activate

# Step 5: Upgrade pip & build tools
echo "⬆️ Upgrading pip, setuptools, wheel..."
pip install --upgrade pip setuptools wheel

# Step 6: Install binary wheels (no compiling)
echo "📦 Installing Python dependencies (binary wheels)..."
pip install --only-binary :all: numpy==1.26.4 scipy==1.13.1 opencv-python==4.9.0.80 playsound==1.3.0 imutils==0.5.4

# Step 7: Install dlib from source
echo "🛠️ Installing dlib (source build, may take a while)..."
pip install dlib==19.24.2

echo "✅ Setup complete! To start detection, run:"
echo "source test_env/bin/activate && python3 drowsiness_yawn.py --shape-predictor ./shape_predictor_68_face_landmarks.dat --alarm ./Alert.wav"

