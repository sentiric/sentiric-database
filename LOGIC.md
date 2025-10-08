# 🧬 Sentiric Database - Veri Katmanı Mimarisi ve Sorumlulukları

**Belge Amacı:** Bu doküman, `sentiric-database` deposunun rolünü, organizasyon yapısını ve platformun neden veritabanı şemalarını ve verilerini iki ayrı repoda (Database ve Config) tuttuğunun mimari gerekçelerini açıklar.

## 1. Stratejik Rol: Platformun Veri Anayasası (Schema Authority)

Bu depo, platformun PostgreSQL, Qdrant veya Redis gibi tüm kalıcı/geçici veri katmanlarında kullanılacak olan **şema (schema) ve yapısal standartların** tek ve resmi kaynağıdır.

### Temel Prensip: Sharding ve Bağımsızlık Hazırlığı

Platformun gelecekteki büyümesinde, veritabanını parçalamamız (sharding) gerekecektir. Bu depo, bu parçalamayı kolaylaştırmak için tasarlanmıştır:

1.  **Çekirdek Şema ve Veri Ayırımı:** `CREATE TABLE` komutları burada yaşar; `INSERT INTO` (veri) komutları **asla** bu depoda tutulmaz.
2.  **Mantıksal Ayrıştırma:** SQL dosyaları, gelecekte farklı sunuculara veya veritabanı türlerine taşınabilme potansiyellerine göre mantıksal gruplara ayrılmıştır.

## 2. PostgreSQL Şema Organizasyonu ve Gelecek Vizyonu

PostgreSQL şeması, tek bir büyük dosyada değil, veri ayrıştırma (sharding) kararlarını destekleyecek **Katman Numaraları** ile düzenlenmiştir.

| Dosya Ön Eki | Katman Adı | Temel İçerik | Sharding Potansiyeli |
| :--- | :--- | :--- | :--- |
| `00_core_platform` | **Çekirdek Varlıklar** | `tenants`, `users`, `contacts`, `sip_credentials`. | **Düşük:** Platformun tamamı için zorunlu, yüksek oranda ilişkili veriler. |
| `01_telephony_routing` | **Telefoni & Routing** | `dialplans`, `inbound_routes`, `sip_trunks`, `outbound_routes`. | **Orta:** Telekoma özel; farklı bir veri merkezi için ayrılabilir. |
| `02_horizontal_capabilities` | **Yatay Kontrol** | `announcements`, `templates`, `cost_models`, `saga_transactions`. | **Düşük:** VCA, RAG ve SAGA gibi merkezi kontrol mekanizmalarını yönetir. |
| `03_cdr_logging` | **Audit & Loglama** | `calls`, `call_events`. | **Yüksek:** Zaman bazlı veya Kiracı bazlı parçalanmanın ana adayıdır (çok yüksek hacim). |
| `04_vertical_business_services` | **Dikey İş Mantığı (VBS)** | `hospitality_reservations`, `health_services`, `ecommerce_orders`, vb. | **Çok Yüksek:** Her bir Dikey İş Servisinin (VBS) kendi veritabanı olmalıdır; şimdilik buraya konarak uyumluluk sağlanır. |
| `99_indexes` | **Performans** | Tüm indeks tanımları. | **N/A** |

## 3. Sorumlulukların Kesin Ayrımı (SoC)

Bu, reformun en önemli kuralıdır:

| Reponun Adı | Sorumluluk Alanı | Kapsam (İçerik) |
| :--- | :--- | :--- |
| **`sentiric-database`** (Bu Repo) | **Veri Anayasası (Schema Authority)** | SADECE `CREATE TABLE`, `CREATE EXTENSION`, `CREATE INDEX`. |
| **`sentiric-config`** | **Veri İlklendirme (Data Seeder)** | SADECE `INSERT INTO` (Sistem verileri, demo verileri, failsafe kuralları). |
| **`sentiric-user-service`** | **Veri Yönetimi (Data Owner)** | `user-service`'in kodu, `users` ve `contacts` tabloları üzerinde `SELECT`, `UPDATE`, `DELETE` yapabilir, ancak şemayı değiştiremez. |

### ÖZET KURAL

**Eğer bir verinin içeriği zamanla değişecek, silinecek veya kullanıcı tarafından yönetilecekse (User, Contact, Rezervasyon), o tablo şemada (`.sql` dosyalarında) tanımlanır.**

**Eğer bir verinin içeriği bir uygulamanın çalışması için zorunluysa ve bir kerelik tanımlanıyorsa (Failsafe Dialplan ID'si, sistem Anonsları), o veri `sentiric-config`'de (INSERT) yaşar.**

Bu döküman, `sentiric-database` reposuna eklenmelidir.