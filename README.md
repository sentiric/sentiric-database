# 💾 Sentiric Database - Veri Anayasası (Schema Authority)

Bu depo, Sentiric platformu tarafından kullanılan tüm veritabanı şemalarının, koleksiyon tanımlarının ve veri yapı standartlarının **tek doğruluk kaynağıdır (Single Source of Truth)**.

**Kritik Kural:** Bu repoda SADECE veritabanı yapısını tanımlayan `CREATE TABLE`, `CREATE INDEX`, `CREATE TYPE` gibi komutlar yer alır. Uygulamanın çalışması için gereken başlangıç verileri (`INSERT` komutları) **`sentiric-config`** reposunda yönetilir.

## ⚙️ PostgreSQL Şema Dosyaları: İsimlendirme ve Sıralama Standardı

Veritabanının tutarlı bir şekilde kurulabilmesi için tüm SQL dosyaları standart bir isimlendirme kuralına uymalıdır. Bu kural, `sentiric-infrastructure` tarafından otomatik olarak doğru sıralamayı garanti eder.

**Dosya Formatı:** `[SIRA]_[TÜR]__[Açıklama].sql`

| Önek | Tür | Sorumluluk | Açıklama |
| :--- | :--- | :--- | :--- |
| `10_V` | **V**ersioned | **Şema Tanımları.** | `CREATE TABLE`, `ALTER TABLE` gibi sadece bir kez çalışması gereken yapısal değişiklikleri içerir. |
| `30_I` | **I**ndexes | **İndeks Tanımları.** | `CREATE INDEX` komutlarını içerir. Performans için tüm tablo ve veri işlemleri bittikten sonra en son çalışır. |

### Örnek Dosya Yapısı (`/sql/postgres/`)

```
/sql/postgres/
├── 10_V01__Create_core_platform.sql
├── 10_V02__Create_telephony_routing.sql
├── ... (diğer şema dosyaları) ...
└── 30_I01__Create_all_indexes.sql
```

Bu yapı, altyapı orkestratörünün önce tüm şemaları (`10_V...`) oluşturmasını, ardından `sentiric-config` reposundan gelen verileri (`20_R...`) eklemesini ve son olarak tüm indeksleri (`30_I...`) oluşturmasını sağlar.

## 📁 Dizin Yapısı ve Diğer Veritabanları

| Dizin | Amaç | İçerik |
| :--- | :--- | :--- |
| `/sql/postgres/` | **PostgreSQL Şeması** | PostgreSQL için atomik `CREATE` komutlarını içerir. |
| `/vector/qdrant/` | **Vektör Veritabanı** | Qdrant koleksiyon tanımlarını ve yapılandırmasını içerir (Planlanan). |
| `/nosql/redis/` | **Cache Şeması** | Redis key isimlendirme standartlarını belgeler (Planlanan). |
