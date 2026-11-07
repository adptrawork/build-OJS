{**
 * templates/frontend/pages/contact.tpl
 * Halaman Kontak Sekretariat
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
        <span class="current">Kontak Sekretariat</span>
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
                <a href="{url page="about" op="submissions"}" class="nav-item">
                    Pedoman Penulis &amp; Reviewer
                </a>
                <a href="{url page="about" op="submissions"}" class="nav-item">
                    Kirim Naskah Online
                </a>
                <a href="{url page="about" op="contact"}" class="nav-item active">
                    <span class="dot"></span>Kontak Sekretariat
                </a>
            </div>
        </aside>

        <!-- Main Content (Kanan) -->
        <div class="about-content">
            <div class="contact-grid">

                <!-- Kiri: Info Kontak -->
                <div class="content-card">
                    <h1 class="content-title">Kontak &amp; Sekretariat</h1>
                    <p class="policy-intro">
                        Hubungi sekretariat Redaksi {$currentJournal->getLocalizedName()|escape} untuk pertanyaan seputar proses publikasi naskah, kendala sistem OJS, atau kolaborasi akademik.
                    </p>

                    <div class="contact-info-list">

                        <!-- Alamat -->
                        <div class="contact-item">
                            <div class="contact-icon">
                                <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                            </div>
                            <div class="contact-text">
                                <span class="contact-label">Alamat Sekretariat</span>
                                {if $currentJournal->getData('mailingAddress')}
                                    <span>{$currentJournal->getData('mailingAddress')|nl2br}</span>
                                {else}
                                    <span>Gedung Ratu Dirgantara Cendekiawan (JRDC), Lantai 3<br>Jl. Raya Dirgantara No. 45, Halim Perdanakusuma<br>Jakarta Timur, DKI Jakarta 13610</span>
                                {/if}
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="contact-item">
                            <div class="contact-icon">
                                <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                            </div>
                            <div class="contact-text">
                                <span class="contact-label">Surel Resmi</span>
                                {if $currentJournal->getData('contactEmail')}
                                    <a href="mailto:{$currentJournal->getData('contactEmail')|escape}">{$currentJournal->getData('contactEmail')|escape}</a>
                                {else}
                                    <a href="mailto:jurnal@jrdc.ac.id">jurnal@jrdc.ac.id</a> / <a href="mailto:support@jrdc.ac.id">support@jrdc.ac.id</a>
                                {/if}
                            </div>
                        </div>

                        <!-- Telepon -->
                        <div class="contact-item">
                            <div class="contact-icon">
                                <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                            </div>
                            <div class="contact-text">
                                <span class="contact-label">Telepon / WhatsApp</span>
                                {if $currentJournal->getData('contactPhone')}
                                    <span>{$currentJournal->getData('contactPhone')|escape}</span>
                                {else}
                                    <span>+62 21 8098 3342 / +62 812 3456 7890</span>
                                {/if}
                            </div>
                        </div>

                        <!-- Jam Kerja -->
                        <div class="contact-item">
                            <div class="contact-icon">
                                <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                            </div>
                            <div class="contact-text">
                                <span class="contact-label">Jam Kerja Sekretariat</span>
                                <span>Senin – Jumat: 08.00 – 16.00 WIB<br>Sabtu &amp; Minggu: Libur</span>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Kanan: Formulir Kontak -->
                <div class="content-card">
                    <h2 class="content-title" style="font-size: 1.25rem;">Kirim Pesan / Pertanyaan</h2>

                    <form action="{url page="about" op="contact"}" method="post" class="contact-form">
                        <div class="form-group">
                            <label>Nama Lengkap</label>
                            <input type="text" name="name" required placeholder="Nama lengkap beserta gelar..." class="form-control">
                        </div>

                        <div class="form-group">
                            <label>Alamat Surel</label>
                            <input type="email" name="email" required placeholder="nama@domain.com" class="form-control">
                        </div>

                        <div class="form-group">
                            <label>Subjek Pesan</label>
                            <select name="subject" class="form-control">
                                <option value="status">Pertanyaan Status Naskah</option>
                                <option value="kendala">Kendala Login / Akun OJS</option>
                                <option value="loa">Permintaan Surat Penerimaan (LoA)</option>
                                <option value="lainnya">Lainnya</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Isi Pesan</label>
                            <textarea name="message" rows="4" required placeholder="Tuliskan pesan atau pertanyaan Anda secara rinci..." class="form-control"></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary" style="width: 100%;">
                            Kirim Pesan
                        </button>
                    </form>
                </div>

            </div>
        </div>
    </div>
</main>

{include file="frontend/components/footer.tpl"}
