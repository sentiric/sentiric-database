# 💾 Sentiric Database - Veri Anayasası (Schema Authority)

Bu depo, Sentiric platformu tarafından kullanılan tüm veritabanı şemalarının, koleksiyon tanımlarının ve veri yapı standartlarının **tek doğruluk kaynağıdır (Single Source of Truth)**.

**Kritik Kural:** Bu repoda SADECE `CREATE TABLE` ve `CREATE INDEX` komutları yer alır. Uygulamanın çalışması için gereken başlangıç verileri (`INSERT` komutları) **`sentiric-config`** reposunda yönetilir.

## 📁 Dizin Yapısı ve Şema Organizasyonu

| Dizin | Amaç | İçerik |
| :--- | :--- | :--- |
| `/sql/postgres/` | **PostgreSQL Şeması** | PostgreSQL için atomik `CREATE TABLE` komutlarını içerir. |
| `/vector/qdrant/` | **Vektör Veritabanı** | Qdrant koleksiyon tanımlarını ve temel yapılandırma YAML'lerini içerir (Planlanan). |
| `/nosql/redis/` | **Cache Şeması** | Redis key isimlendirme standartlarını ve TTL politikalarını belgeleyen dosyalar (Planlanan). |

## ⚙️ PostgreSQL Şema Dosyaları (Mantıksal Ayrım)

| Dosya Adı | Kapsam | Ana Servis Odak Noktası |
| :--- | :--- | :--- |
| `00_core_platform.sql` | `tenants`, `users`, `contacts`, `sip_credentials`. | `user-service`, `registrar-service` |
| `01_telephony_routing.sql` | `dialplans`, `inbound_routes`, `sip_trunks`, `outbound_routes`. | `dialplan-service` |
| `02_horizontal_capabilities.sql`| `announcements`, `templates`, `cost_models`, `saga_transactions`. | `agent-service` |
| `03_cdr_logging.sql` | `calls`, `call_events`. | `cdr-service` |
| `04_vertical_business_services.sql` | Dikey Servislerin (Health, Finance, vb.) tabloları. | VBS Servisleri |
| `05_rag_knowledge_base.sql` | `datasources` ve RAG ile ilgili diğer yapılar. | `knowledge-indexing-service` |
| `99_indexes.sql` | Tüm tablo indeksleri. | Performans |