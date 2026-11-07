{**
 * templates/frontend/pages/about.tpl
 * Halaman Tentang Jurnal
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
        <span class="current">Tentang Jurnal</span>
    </nav>

    <div class="about-layout">
        <!-- Sidebar Navigation (Kiri) -->
        <aside class="about-sidebar">
            <div class="sidebar-nav-card">
                <a href="{url page="about"}" class="nav-item active">
                    <span class="dot"></span>Tentang Jurnal
                </a>
                <a href="{url page="about" op="editorialTeam"}" class="nav-item">
                    Dewan Redaksi
                </a>
                <a href="{url page="about"}" class="nav-item">
                    Kebijakan Etika &amp; Peer Review
                </a>
                <a href="{url page="about" op="submissions"}" class="nav-item">
                    Pedoman Penulis &amp; Reviewer
                </a>
                <a href="{url page="about" op="submissions"}" class="nav-item">
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

                <h1 class="content-title">Tentang {$currentJournal->getLocalizedName()|escape}</h1>

                <div class="content-section">
                    {if $currentJournal->getLocalizedData('about')}
                        {$currentJournal->getLocalizedData('about')}
                    {elseif $currentJournal->getLocalizedData('description')}
                        {$currentJournal->getLocalizedData('description')}
                    {else}
                        <p><strong>Jurnal Ekonomi dan Bisnis JRDC</strong> (ISSN: 2985-671X) adalah jurnal ilmiah peer-reviewed akses terbuka yang diterbitkan oleh Yayasan Ratu Dirgantara Cendekiawan (JRDC). Jurnal ini berdedikasi untuk menyebarluaskan hasil riset, kajian teoretis, dan pemikiran konseptual di bidang ekonomi, manajemen bisnis, akuntansi, perbankan syariah, dan kewirausahaan.</p>
                        <p>Didirikan sebagai wadah publikasi ilmiah bagi akademisi, peneliti, praktisi industri, dan mahasiswa pascasarjana, JRDC berkomitmen untuk menjaga standar kualitas akademik tertinggi melalui proses seleksi naskah yang ketat dan telaah sejawat (<em class="italic text-primary font-medium">double-blind peer review</em>).</p>
                    {/if}
                </div>

                <div class="content-section border-top">
                    <h2>Fokus &amp; Ruang Lingkup (Focus &amp; Scope)</h2>
                    {if $currentJournal->getLocalizedData('focusScope')}
                        {$currentJournal->getLocalizedData('focusScope')}
                    {else}
                        <p>Jurnal Ekonomi dan Bisnis JRDC menerima artikel riset empiris maupun konseptual yang mencakup berbagai bidang utama:</p>
                        <ul class="content-list">
                            <li><strong>Ekonomi Makro &amp; Mikro:</strong> Kebijakan moneter, fiskal, pertumbuhan ekonomi, ekonomi pembangunan, dan ekonomi regional.</li>
                            <li><strong>Manajemen &amp; Bisnis:</strong> Manajemen strategis, pemasaran digital, perilaku konsumen, manajemen sumber daya manusia, dan keuangan perusahaan.</li>
                            <li><strong>Perbankan &amp; Keuangan Syariah:</strong> Perbankan syariah, fintech, manajemen risiko pembiayaan mudharabah/musyarakah, dan akuntansi syariah.</li>
                            <li><strong>Akuntansi &amp; Perpajakan:</strong> Akuntansi keuangan, akuntansi sektor publik, auditing, tata kelola perusahaan (GCG), dan perpajakan.</li>
                            <li><strong>Kewirausahaan &amp; UMKM:</strong> Inovasi bisnis, pengembangan UMKM, ekonomi digital, dan kewirausahaan sosial.</li>
                        </ul>
                    {/if}
                </div>

                <div class="content-section border-top">
                    <h2>Frekuensi Penerbitan</h2>
                    {if $currentJournal->getLocalizedData('publicationFrequency')}
                        {$currentJournal->getLocalizedData('publicationFrequency')}
                    {else}
                        <p>Jurnal ini terbit secara berkala dua kali dalam setahun (semi-annual), yaitu pada bulan <strong>April</strong> dan <strong>Oktober</strong>. Setiap edisi memuat antara 6 hingga 10 artikel pilihan yang telah melalui tahapan review dan revisi menyeluruh.</p>
                    {/if}
                </div>

                <div class="content-section border-top">
                    <h2>Pernyataan Akses Terbuka (Open Access Statement)</h2>
                    {if $currentJournal->getLocalizedData('openAccessPolicy')}
                        {$currentJournal->getLocalizedData('openAccessPolicy')}
                    {else}
                        <p>Jurnal Ekonomi dan Bisnis JRDC menganut prinsip akses terbuka penuh (<em class="italic font-medium">Full Open Access</em>). Seluruh artikel yang diterbitkan dapat diunduh, dibaca, disebarluaskan, dan dicetak secara gratis tanpa dipungut biaya oleh pembaca atau institusi, sesuai dengan lisensi Creative Commons Attribution (CC BY 4.0).</p>
                    {/if}
                </div>

                <div class="content-section border-top">
                    <h2>Pemberitahuan Hak Cipta &amp; Lisensi</h2>
                    {if $currentJournal->getLocalizedData('copyrightNotice')}
                        {$currentJournal->getLocalizedData('copyrightNotice')}
                    {else}
                        <p>Hak cipta atas setiap artikel yang dipublikasikan dipegang oleh penulis dengan persetujuan penerbit (Yayasan Ratu Dirgantara Cendekiawan). Penulis memberikan hak kepada jurnal untuk mempublikasikan artikel pertama kalinya di bawah lisensi CC BY 4.0 yang mengizinkan pihak lain untuk membagikan karya dengan pengakuan kepenulisan dan publikasi awal di jurnal ini.</p>
                    {/if}
                </div>

            </div>
        </div>
    </div>
</main>

{include file="frontend/components/footer.tpl"}
