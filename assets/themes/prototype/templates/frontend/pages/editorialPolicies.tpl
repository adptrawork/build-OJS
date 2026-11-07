{**
 * templates/frontend/pages/editorialPolicies.tpl
 * Halaman Kebijakan Publikasi & Etika
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
        <a href="{url page="about"}">Tentang</a>
        <span>/</span>
        <span class="current">Kebijakan Publikasi &amp; Etika</span>
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
                <a href="{url page="about"}" class="nav-item active">
                    <span class="dot"></span>Kebijakan Etika &amp; Peer Review
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

                <h1 class="content-title">Kebijakan Publikasi &amp; Etika Ilmiah</h1>

                <p class="policy-intro">
                    {$currentJournal->getLocalizedName()|escape} menjunjung tinggi standar integritas akademik dan etika publikasi tertinggi berdasarkan pedoman Committee on Publication Ethics (COPE).
                </p>

                <!-- Section 1: Peer Review Process -->
                <div class="policy-section border-top">
                    <h2>Proses Telaah Sejawat (Peer Review Process)</h2>
                    {if $currentJournal->getLocalizedData('peerReviewPolicy')}
                        <div class="policy-text">{$currentJournal->getLocalizedData('peerReviewPolicy')}</div>
                    {else}
                        <p class="policy-text">
                            Setiap naskah yang dikirimkan ke Jurnal JRDC akan melalui proses <em class="italic text-primary font-medium">Double-Blind Peer Review</em>. Identitas penulis disembunyikan dari reviewer, dan identitas reviewer disembunyikan dari penulis untuk menjamin objektivitas penilaian akademik. Rata-rata durasi peninjauan awal hingga keputusan editor adalah 4 hingga 6 minggu.
                        </p>
                    {/if}
                </div>

                <!-- Section 2: Plagiarism Check -->
                <div class="policy-section border-top">
                    <h2>Kebijakan Plagiarisme &amp; Plagiarism Check</h2>
                    {if $currentJournal->getLocalizedData('plagiarismPolicy')}
                        <div class="policy-text">{$currentJournal->getLocalizedData('plagiarismPolicy')}</div>
                    {else}
                        <p class="policy-text">
                            Redaksi JRDC secara ketat menolak segala bentuk plagiarisme, fabrikasi data, dan duplikasi publikasi. Setiap naskah yang masuk akan diperiksa tingkat kemiripannya menggunakan perangkat lunak <strong>Turnitin</strong> dengan ambang batas maksimal kemiripan (similarity index) sebesar <strong>20%</strong>.
                        </p>
                    {/if}
                </div>

                <!-- Section 3: AI Usage Policy -->
                <div class="policy-section border-top">
                    <h2>Kebijakan Penggunaan Kecerdasan Buatan (AI Usage Policy)</h2>
                    <p class="policy-text">
                        Penggunaan alat bantu berbasis AI (seperti LLM untuk penyuntingan bahasa atau penerjemahan) diizinkan selama dinyatakan secara transparan pada bagian catatan metodologi atau pengantar naskah. AI tidak diizinkan untuk bertindak sebagai penulis (co-author), dan penulis bertanggung jawab penuh atas keakuratan isi naskah.
                    </p>
                </div>

                <!-- Section 4: Article Processing Charge (APC) -->
                <div class="policy-section border-top">
                    <h2>Article Processing Charge (APC)</h2>
                    {if $currentJournal->getLocalizedData('authorFees')}
                        <div class="policy-text">{$currentJournal->getLocalizedData('authorFees')}</div>
                    {else}
                        <p class="policy-text">
                            Jurnal ini tidak memungut biaya apa pun (Zero APC) untuk proses pengiriman, telaah sejawat, maupun penerbitan artikel. Seluruh biaya operasional jurnal ditanggung sepenuhnya oleh Yayasan Ratu Dirgantara Cendekiawan (JRDC).
                        </p>
                    {/if}
                </div>

            </div>
        </div>
    </div>
</main>

{include file="frontend/components/footer.tpl"}
