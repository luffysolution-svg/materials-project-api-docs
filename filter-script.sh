#!/bin/bash
# Git历史清理脚本 - 替换API密钥

FILE="01-API完整使用指南.md"

if [ -f "$FILE" ]; then
    sed -i 's/8Fv89Xd3xCyJxw9oyc2srbKbHBqA9MGK/YOUR_API_KEY_HERE/g' "$FILE"
fi
