# 🧬 Sentiric Database - Veri Katmanı Mimarisi ve Sorumlulukları

**Belge Amacı:** Bu doküman, `sentiric-database` deposunun rolünü, organizasyon yapısını ve platformun PostgreSQL, Qdrant veya Redis gibi tüm kalıcı/geçici veri katmanlarında kullanılacak olan **şema (schema) ve yapısal standartların** tek ve resmi kaynağı olduğunu açıklar.

## 1. Stratejik Rol: Platformun Veri Anayasası (Schema Authority)

Bu depo, platformun PostgreSQL, Qdrant veya Redis gibi tüm kalıcı/geçici veri katmanlarında kullanılacak olan **şema (schema) ve yapısal standartların** tek ve resmi kaynağıdır.

### Temel Prensip: Sharding ve Mikroservis Ayrıştırmasına Hazırlık

SQL şemaları, gelecekteki potansiyel veri ayrıştırma (sharding) veya her mikroservisin kendi veritabanını kullanması (Database per Service) ihtimalini destekleyecek şekilde mantıksal Katman Numaraları ile düzenlenmiştir.

| Dosya Ön Eki | Katman Adı | Temel İçerik | Sharding Potansiyeli | Ana Servis Odak Noktası |
| :--- | :--- | :--- | :--- | :--- |
| `00_core_platform` | **Çekirdek Varlıklar** | `tenants`, `users`, `contacts`, `sip_credentials`. | Düşük | `user-service`, `registrar-service` |
| `01_telephony_routing` | **Telefoni & Routing** | `dialplans`, `inbound_routes`, `sip_trunks`. | Orta | `dialplan-service` |
| `02_horizontal_capabilities` | **Yatay Kontrol** | `announcements`, `templates`, `datasources`, `saga_transactions`. | Düşük | `agent-service`, `knowledge-service` |
| `03_cdr_logging` | **Audit & Loglama** | `calls`, `call_events`. | Yüksek | `cdr-service` |
| `04_vertical_business_services` | **Dikey İş Mantığı (VBS)** | `health_services`, `finance_accounts`, vb. | Çok Yüksek | VBS Servisleri (`health-service`, vb.) |
| `99_indexes` | **Performans** | Tüm indeks tanımları. | N/A | Tüm Servisler |

## 2. Sorumlulukların Kesin Ayrımı (SoC) - (Kritik Kural)

Bu, reformun en önemli kuralıdır:

| Reponun Adı | Sorumluluk Alanı | Kapsam (İçerik) |
| :--- | :--- | :--- |
| **`sentiric-database`** (Bu Repo) | **Veri Anayasası (Schema Authority)** | YALNIZCA `CREATE TABLE`, `CREATE EXTENSION`, `CREATE TYPE`, `CREATE INDEX` gibi **şema tanımlarını** içerir. |
| **`sentiric-config`** | **Veri İlklendirme (Data Seeder)** | YALNIZCA `INSERT INTO` gibi **başlangıç/demo verilerini** içerir. |
| **Uygulama Servisleri** | **İş Mantığı (CRUD)** | `SELECT`, `UPDATE`, `DELETE`, `UPSERT` gibi çalışma zamanı veri işlemlerini yürütür. |

### ÖZET KURAL

**`sentiric-database` reponuzdaki hiçbir `.sql` dosyası bir `INSERT` komutu içermemelidir.**