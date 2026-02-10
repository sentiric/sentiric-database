# 🧬 Veri Katmanı Mantığı: Dağıtık Veri Ağı

**Mimari Karar:** Monolitik `postgres` yapısı terk edilmiş, **Database-per-Service** modeline geçilmiştir.

## Veri Sahipliği Haritası

| Servis | Veritabanı Adı | Sorumluluk Alanı |
| :--- | :--- | :--- |
| **User Service** | `sentiric_user` | Kimlik, Kiracılar (Tenants), İletişim Kanalları. |
| **Dialplan Service** | `sentiric_dialplan` | Telefon numaraları, yönlendirme kuralları, operatör tanımları. |
| **Agent Service** | `sentiric_agent` | SAGA işlemleri, Anons dosyası yolları, LLM Prompt şablonları. |
| **CDR Service** | `sentiric_cdr` | Çağrı kayıtları (Logs), Maliyet hesaplama modelleri (VCA). |
| **Knowledge Service** | `sentiric_knowledge` | RAG kaynak tanımları (Metadata). |

Bu yapı, bir servisin veritabanı çöktüğünde diğerlerinin etkilenmemesini (Bulkhead Pattern) garanti eder.

