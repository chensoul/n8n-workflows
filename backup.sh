: ${EXPORT_DIR="workflow-$(date +%Y%m%d)"}
rm -rf $EXPORT_DIR/*

docker exec -u node -it n8n n8n export:workflow --backup --output=./$EXPORT_DIR/
docker cp n8n:/home/node/$EXPORT_DIR .

#docker exec -u node -it n8n n8n export:credentials --all --output=./credentials.json
#docker cp n8n:/home/node/credentials.json .

cd $EXPORT_DIR
for file in *; do
    filename=$(cat "$file" | jq -r '.name')  # 使用-r选项以纯文本形式输出字段值
    echo "$filename"
    mv "$file" "$filename".json
done
