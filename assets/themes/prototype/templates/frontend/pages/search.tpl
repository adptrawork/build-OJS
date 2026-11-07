{**
 * templates/frontend/pages/search.tpl
 * Halaman Hasil Pencarian
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
        <span class="current">Pencarian Artikel</span>
    </nav>

    <div class="search-layout">

        <!-- Sidebar (Kiri): Filter -->
        <div class="search-sidebar">
            <div class="content-card">
                <h2 class="filter-title">
                    Filter Pencarian
                </h2>

                <form action="{url page="search" op="search"}" method="get" class="search-form">
                    <div class="form-group">
                        <label>Kata Kunci</label>
                        <input type="text" name="query" value="{$query|escape}" placeholder="Masukkan kata kunci..." class="form-control">
                    </div>

                    <div class="form-group">
                        <label>Penulis</label>
                        <input type="text" name="authors" value="{$authors|escape}" placeholder="Nama penulis..." class="form-control">
                    </div>

                    <button type="submit" class="btn btn-primary btn-block">Terapkan Filter</button>
                </form>
            </div>
        </div>

        <!-- Konten Utama (Kanan): Hasil Pencarian -->
        <div class="search-content">

            <!-- Header Hasil -->
            <div class="content-card search-header-card">
                <div>
                    <h1 class="search-title">Hasil Pencarian{if $query}: <span class="text-primary">"{$query|escape}"</span>{/if}</h1>
                    <span class="search-subtitle">Ditemukan {$results->count} artikel yang sesuai dengan kriteria</span>
                </div>
                <span class="search-count-badge">{$results->count} Hasil</span>
            </div>

            <!-- Daftar Artikel -->
            <div class="search-results-list">
                {if !$results->wasEmpty()}
                    {iterate from=results item=result}
                        <div class="search-result-card">

                            <!-- Meta Top -->
                            <div class="result-meta">
                                <span class="text-primary font-bold">
                                    {if $result.issue}
                                        Vol. {$result.issue->getVolume()} No. {$result.issue->getNumber()} ({$result.issue->getYear()})
                                    {else}
                                        Artikel
                                    {/if}
                                </span>
                                {if $result.article->getPages()}
                                    <span>Hal. {$result.article->getPages()|escape}</span>
                                {/if}
                            </div>

                            <!-- Judul -->
                            <h2 class="result-title">
                                <a href="{url page="article" op="view" path=$result.article->getBestArticleId()}">
                                    {$result.article->getLocalizedTitle()|escape}
                                </a>
                            </h2>

                            <!-- Penulis -->
                            <p class="result-authors">
                                {$result.article->getAuthorString()|escape}
                            </p>

                            <!-- Abstrak -->
                            {if $result.article->getLocalizedAbstract()}
                                <p class="result-abstract">
                                    {$result.article->getLocalizedAbstract()|strip_tags|truncate:250}
                                </p>
                            {/if}

                            <!-- Footer & Tombol -->
                            <div class="result-footer">
                                <div class="result-stats">
                                    <span>{$result.article->getViews()|default:0} Dilihat</span>
                                </div>
                                <div class="result-actions">
                                    <a href="{url page="article" op="view" path=$result.article->getBestArticleId()}" class="btn btn-outline">
                                        Lihat Detail
                                    </a>

                                    {foreach from=$result.article->getGalleys() item=galley name=galleyLoop}
                                        {if $galley->isPdfGalley()}
                                            <a href="{url page="article" op="view" path=$result.article->getBestArticleId()|to_array:$galley->getBestGalleyId()}" class="btn btn-primary">
                                                Unduh PDF
                                            </a>
                                        {/if}
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                    {/iterate}
                {else}
                    <!-- Empty State -->
                    <div class="content-card empty-search">
                        <h3>Tidak Ada Hasil Ditemukan</h3>
                        <p>Kami tidak dapat menemukan artikel yang cocok dengan kata kunci "<strong>{$query|escape}</strong>". Coba gunakan kata kunci lain atau periksa ejaan Anda.</p>
                    </div>
                {/if}
            </div>

        </div>
    </div>
</main>

{include file="frontend/components/footer.tpl"}
