# 💾 Sentiric Database - Veri Anayasası

Bu depo, Sentiric platformu tarafından kullanılan tüm veritabanı şemalarının, koleksiyon tanımlarının ve veri yapı standartlarının **tek doğruluk kaynağıdır (Single Source of Truth)**.

Bu depo, veri katmanını uygulama mantığından tamamen ayırır. Uygulama servisleri (User, Dialplan, vb.) bu şemaları kullanır, ancak bu depoda herhangi bir uygulama kodu bulunmaz.

## 📁 Dizin Yapısı ve Sorumluluklar

| Dizin | Amaç | İçerik |
| :--- | :--- | :--- |
| `/sql/postgres/` | **PostgreSQL Şeması** | `CREATE TABLE`, `CREATE INDEX` komutlarını içerir. Bu dosyalar, `sentiric-postgres` imajı tarafından başlangıçta otomatik olarak yüklenir. |
| `/vector/qdrant/` | **Vektör Veritabanı** | Qdrant koleksiyon tanımlarını ve temel yapılandırma YAML'lerini içerir. |
| `/nosql/redis/` | **Cache Şeması** | Redis key isimlendirme standartlarını ve TTL politikalarını belgeleyen dosyalar. |

## ⚙️ PostgreSQL Şeması Yükleme

PostgreSQL şeması, mantıksal gruplara ayrılmıştır:

| Dosya Adı | Kapsam |
| :--- | :--- |
| `00_core_platform.sql` | Kullanıcı, Kiracı, Kimlik (users, tenants) |
| `01_telephony_routing.sql` | Dialplan, Inbound Routes, SIP Trunk'lar |
| `02_horizontal_capabilities.sql`| RAG, VCA (Maliyet Modelleri), Saga |
| `03_cdr_logging.sql` | Çağrı Kayıtları (calls, call_events) |
| `99_indexes.sql` | Tüm tablo indeksleri |