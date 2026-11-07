{**
 * templates/frontend/pages/editorialTeam.tpl
 * Halaman Dewan Redaksi
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
        <span class="current">Dewan Redaksi</span>
    </nav>

    <div class="about-layout">
        <!-- Sidebar Navigation (Kiri) -->
        <aside class="about-sidebar">
            <div class="sidebar-nav-card">
                <a href="{url page="about"}" class="nav-item">
                    Tentang Jurnal
                </a>
                <a href="{url page="about" op="editorialTeam"}" class="nav-item active">
                    <span class="dot"></span>Dewan Redaksi
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

                <h1 class="content-title">Dewan Redaksi &amp; Mitra Bestari</h1>

                <p class="team-intro">
                    {$currentJournal->getLocalizedName()|escape} dikelola oleh jajaran Dewan Redaksi, Editor Ahli, dan Mitra Bestari (<em class="italic">Reviewer</em>) dari berbagai perguruan tinggi terkemuka di Indonesia dan internasional.
                </p>

                {if $editorialTeam}
                    {foreach from=$editorialTeam item=teamGroup name=groupLoop}
                        <div class="team-section">
                            <h2 class="team-section-title">{$teamGroup.name|escape}</h2>
                            <div class="team-grid">
                                {foreach from=$teamGroup.users item=user name=userLoop}
                                    <div class="team-member-card">
                                            <div class="member-info">
                                            <h3>{$user->getFullName()|escape}</h3>
                                            <p class="role">{$teamGroup.name|escape}</p>
                                            {if $user->getLocalizedAffiliation()}
                                                <p class="affiliation">{$user->getLocalizedAffiliation()|escape}</p>
                                            {/if}
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/foreach}
                {else}
                    <!-- Fallback data -->
                    <div class="team-section">
                        <h2 class="team-section-title">Pimpinan Redaksi (Editor-in-Chief)</h2>
                        <div class="team-grid grid-2-col">
                            <div class="team-member-card">
                                <div class="member-info">
                                    <h3>Prof. Dr. Ahmad Fauzi, S.E., M.Si.</h3>
                                    <p class="role">Pimpinan Redaksi</p>
                                    <p class="affiliation">Universitas Ratu Dirgantara, Indonesia</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="team-section">
                        <h2 class="team-section-title">Editor Pelaksana (Managing Editors)</h2>
                        <div class="team-grid grid-2-col">
                            <div class="team-member-card">
                                <div class="member-info">
                                    <h3>Dr. Dewi Lestari, S.E., M.B.A.</h3>
                                    <p class="role">Managing Editor</p>
                                    <p class="affiliation">Universitas Indonesia</p>
                                </div>
                            </div>
                            <div class="team-member-card">
                                <div class="member-info">
                                    <h3>Hendra Wijaya, Ph.D.</h3>
                                    <p class="role">Section Editor - Keuangan Syariah</p>
                                    <p class="affiliation">UIN Syarif Hidayatullah</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="team-section">
                        <h2 class="team-section-title">Dewan Penyunting (Editorial Board Members)</h2>
                        <div class="team-grid">
                            <div class="team-member-card">
                                <div class="member-info">
                                    <h3>Prof. Dr. Budi Santoso, M.Sc.</h3>
                                    <p class="role">Dewan Penyunting</p>
                                    <p class="affiliation">Universitas Gadjah Mada</p>
                                </div>
                            </div>
                            <div class="team-member-card">
                                <div class="member-info">
                                    <h3>Dr. Rina Utami, Ak., M.CA.</h3>
                                    <p class="role">Dewan Penyunting</p>
                                    <p class="affiliation">Universitas Airlangga</p>
                                </div>
                            </div>
                            <div class="team-member-card">
                                <div class="member-info">
                                    <h3>Dr. Eko Prasetyo, M.M.</h3>
                                    <p class="role">Dewan Penyunting</p>
                                    <p class="affiliation">Institut Pertanian Bogor</p>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}

            </div>
        </div>
    </div>
</main>

{include file="frontend/components/footer.tpl"}
