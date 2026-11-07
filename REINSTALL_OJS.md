# Reinstall OJS 3.3 untuk perbaikan error 500

## Status saat ini
- OJS 3.3 instalasi rusak (file CacheManager.inc.php corrupt, kemudian DB connection error)
- DB backup tersedia: `/tmp/ojs-db-backup-20261107-014640.sql.gz`
- Tema `prototype` sudah siap di `plugins/themes/prototype/`

## Langkah reinstall

### 1. Backup data penting
```bash
# Backup config
cp ojs-jrdc/config.inc.php ojs-jrdc/config.inc.php.backup

# Backup tema yang sudah dibuat
cp -r ojs-jrdc/plugins/themes/prototype /tmp/prototype-theme-backup/

# Backup files_dir jika ada data upload
tar -czf /tmp/ojs-files-backup.tar.gz ojs-jrdc/public/journals/ 2>/dev/null || true
```

### 2. Hapus instalasi OJS yang rusak
```bash
# Hapus semua file OJS kecuali config dan data
mv ojs-jrdc ojs-jrdc-corrupt
mkdir ojs-jrdc
cp ojs-jrdc-corrupt/config.inc.php.backup ojs-jrdc/config.inc.php
```

### 3. Download dan install OJS 3.3.0-24 fresh
```bash
cd /mnt/DiskD/Projects/ojs
wget "https://pkp.sfu.ca/ojs/download/ojs-3.3.0-24.tar.gz" -O ojs-3.3.0-24.tar.gz
tar -xzf ojs-3.3.0-24.tar.gz
mv ojs-3.3.0-24/* ojs-jrdc/
rm -rf ojs-3.3.0-24 ojs-3.3.0-24.tar.gz
```

### 4. Update config.inc.php untuk DDEV
Edit `ojs-jrdc/config.inc.php`:
```ini
[database]
driver = mysqli
host = db
username = db
password = db
name = db
```

### 5. Restore DB dari backup
```bash
gunzip -c /tmp/ojs-db-backup-20261107-014640.sql.gz | ddev mysql
```

### 6. Install tema `prototype`
```bash
# Copy tema ke plugins/themes
cp -r /tmp/prototype-theme-backup ojs-jrdc/plugins/themes/prototype

# Install via CLI (jika tools bekerja)
ddev exec "php tools/installPluginVersion.php plugins/themes/prototype/version.xml"
```

### 7. Aktifkan tema
```bash
# Set tema sebagai aktif
ddev mysql -e "UPDATE journal_settings SET setting_value = 'prototype' WHERE setting_name = 'themePluginPath' AND journal_id = 1"
```

### 8. Clear cache
```bash
rm -rf ojs-jrdc/cache/*
ddev restart
```

## Verifikasi
Akses: https://jrdc-ojs.ddev.site:8443/index.php/jrdc/

## Jika masih error 500
1. Cek error log: `ddev logs -s web`
2. Clear template cache: hapus `ojs-jrdc/cache/t_compile/*`
3. Jalankan upgrade script: `ddev exec "php tools/upgrade.php upgrade"`

## Alternatif: gunakan OJS 3.5
Jika OJS 3.3 tetap bermasalah, gunakan OJS 3.5 dari backup:
```bash
# Extract backup OJS 3.5
tar -xzf /mnt/DiskD/Workspace/Backups/ojs-jrdc/2026-11-06-pre-3.3/ojs-jrdc-3.5.tar.gz
mv ojs-jrdc-3.5/* ojs-jrdc/

# Restore DB OJS 3.5
gunzip -c /mnt/DiskD/Workspace/Backups/ojs-jrdc/2026-11-06-pre-3.3/db-ojs35.sql.gz | ddev mysql

# Update tema untuk OJS 3.5 (perlu penyesuaian namespace)
```

## Catatan
- Tema `prototype` dibuat untuk OJS 3.3 (non-namespaced)
- Jika upgrade ke OJS 3.5, tema perlu diupdate (namespace, Hook::add, Repo::)
- Error 500 saat ini bukan disebabkan tema, tapi instalasi OJS rusak