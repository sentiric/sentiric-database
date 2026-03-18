<!-- Dosya: TASKS.md -->

## Mimari Uyum (Architecture Compliance)
- [x] `sql/postgres/workflow/01_tables/02_sessions.sql`: Gerçek zamanlı çağrı/oturum durumu (`status = 'RUNNING'`, `current_step_id`) barındıran tablo tasarımı kural ihlali sebebiyle iptal edildi. Mimari spesifikasyonlara göre (bkz: `constraints.yaml` -> `state_management`), tablo `workflow_execution_logs` olarak yeniden yazıldı ve aktif state takibi Redis'e delege edildi.