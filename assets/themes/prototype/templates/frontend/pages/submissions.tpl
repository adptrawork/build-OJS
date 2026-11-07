{**
 * templates/frontend/pages/submissions.tpl
 * Halaman Panduan Pengiriman Naskah
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape|default:'#c2410c'};
    }
</style>

<main class="container about-page">

    <!-- Breadcrumbs -->
    <nav class="breadcrumbs">
        <a href="{url page="index"}">Beranda</a>
        <span>/</span>
        <span class="current">Pengiriman Naskah</span>
    </nav>

    <div class="about-layout">
        <!-- Sidebar Navigation (Kiri) -->
        <aside class="about-sidebar">
            <div class="sidebar-nav-card">
                <a href="{url page="about"}" class="nav-item">
                    Tentang Jurnal
                </a>
                <a href="{url page="about" op="editorialTeam"}" class="nav-item">
                    Dewan Redaksi
                </a>
                <a href="{url page="about" op="editorialPolicies"}" class="nav-item">
                    Kebijakan Etika &amp; Peer Review
                </a>
                <a href="{url page="about" op="submissions"}" class="nav-item active">
                    <span class="dot"></span>Pedoman &amp; Kirim Naskah
                </a>
                <a href="{url page="submission" op="wizard"}" class="nav-item">
                    Kirim Naskah Online
                </a>
                <a href="{url page="about" op="contact"}" class="nav-item">
                    Kontak Sekretariat
                </a>
            </div>
        </aside>

        <!-- Main Content (Kanan) -->
        <div class="about-content">
            <div class="content-card">

                <h1 class="content-title">Pengiriman Naskah Online (Online Submissions)</h1>

                <!-- Alert Box -->
                <div class="alert-box">
                    <div class="alert-header">
                        <svg class="alert-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                        Informasi Penting Sebelum Mengirim Naskah
                    </div>
                    <p class="alert-text">
                        Penulis wajib memastikan bahwa naskah yang dikirimkan belum pernah dipublikasikan sebelumnya dan tidak sedang dalam proses evaluasi di jurnal lain. Seluruh naskah wajib menggunakan <strong>Templat Naskah Resmi JRDC (.docx)</strong>.
                    </p>
                    <div class="alert-action">
                        <a href="#" onclick="alert('Mengunduh templat naskah resmi (.docx)...'); return false;" class="btn btn-alert">
                            <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                            Unduh Templat Naskah (.docx)
                        </a>
                    </div>
                </div>

                <!-- Checklist -->
                <div class="submission-section">
                    <h2>Daftar Periksa Persiapan Naskah (Author Checklist)</h2>
                    <p class="text-muted">Sebelum mengirimkan naskah melalui sistem OJS, pastikan Anda telah melengkapi seluruh poin berikut:</p>

                    <div class="checklist-container">
                        <label class="checklist-item">
                            <input type="checkbox" class="checklist-input">
                            <span class="checklist-text">Naskah dikirim dalam format Microsoft Word (.doc / .docx) sesuai templat jurnal.</span>
                        </label>
                        <label class="checklist-item">
                            <input type="checkbox" class="checklist-input">
                            <span class="checklist-text">Panjang naskah antara 5.000 hingga 8.000 kata termasuk referensi dan tabel.</span>
                        </label>
                        <label class="checklist-item">
                            <input type="checkbox" class="checklist-input">
                            <span class="checklist-text">Seluruh kutipan dan daftar pustaka menggunakan format APA 7th Edition (disarankan menggunakan Mendeley/Zotero).</span>
                        </label>
                    </div>
                </div>

                <!-- Langkah Pengiriman -->
                <div class="submission-section border-top">
                    <h2>Langkah Pengiriman Online</h2>
                    <ol class="steps-list">
                        <li><strong>Registrasi Akun:</strong> Penulis harus memiliki akun aktif di situs Jurnal JRDC. Jika belum memiliki akun, silakan daftar melalui menu <a href="{url page="user" op="register"}">Daftar</a>.</li>
                        <li><strong>Masuk (Login):</strong> Masuk ke sistem menggunakan akun penulis terdaftar.</li>
                        <li><strong>Mulai Pengiriman Baru:</strong> Klik tombol <span class="text-bold">"New Submission"</span> pada dashboard penulis OJS.</li>
                        <li><strong>Unggah Berkas:</strong> Unggah naskah utama (tanpa identitas penulis untuk keperluan blind review) serta lampiran pendukung.</li>
                        <li><strong>Lengkapi Metadata:</strong> Masukkan judul, abstrak, kata kunci, dan afiliasi seluruh penulis secara akurat.</li>
                    </ol>
                </div>

                <!-- CTA Button -->
                <div class="submission-cta">
                    <a href="{url page="submission" op="wizard"}" class="btn btn-primary btn-lg">
                        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path><polyline points="10 17 15 12 10 7"></polyline><line x1="15" y1="12" x2="3" y2="12"></line></svg>
                        Masuk &amp; Kirim Naskah via OJS
                    </a>
                </div>

            </div>
        </div>
    </div>
</main>

{include file="frontend/components/footer.tpl"}
