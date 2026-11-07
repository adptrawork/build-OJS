{**
 * templates/frontend/pages/user/register.tpl
 * Halaman Pendaftaran Akun
 *}
{include file="frontend/components/header.tpl"}

<style>
    :root {
        --primary-color: {$activeTheme->getOption('primaryColor')|escape|default:'#c2410c'};
    }
</style>

<div class="login-page">
    <div class="login-container" style="max-width: 540px;">
        <div class="content-card login-card">

            <div class="login-header">
                <div class="login-icon">
                    <svg width="32" height="32" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                        <circle cx="8.5" cy="7" r="4"></circle>
                        <line x1="20" y1="8" x2="20" y2="14"></line>
                        <line x1="23" y1="11" x2="17" y2="11"></line>
                    </svg>
                </div>
                <h1 class="login-title">Pendaftaran Akun Penulis</h1>
                <p class="login-subtitle">Bergabunglah sebagai penulis atau reviewer {$currentJournal->getLocalizedName()|escape|default:'Jurnal Ekonomi dan Bisnis JRDC'}</p>
            </div>

            <form action="{url page="user" op="register"}" method="post" class="login-form">
                {csrf}

                <div class="form-row">
                    <div class="form-group">
                        <label for="givenName">Nama Depan</label>
                        <input type="text" name="givenName" id="givenName" required class="form-control" value="{$givenName|escape|default:''}">
                    </div>
                    <div class="form-group">
                        <label for="familyName">Nama Belakang</label>
                        <input type="text" name="familyName" id="familyName" required class="form-control" value="{$familyName|escape|default:''}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="affiliation">Afiliasi / Institusi</label>
                    <input type="text" name="affiliation" id="affiliation" required class="form-control" value="{$affiliation|escape|default:''}">
                </div>

                <div class="form-group">
                    <label for="email">Alamat Surel (Email)</label>
                    <input type="email" name="email" id="email" required class="form-control" value="{$email|escape|default:''}">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="password">Kata Sandi</label>
                        <input type="password" name="password" id="password" required class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="password2">Ulangi Kata Sandi</label>
                        <input type="password" name="password2" id="password2" required class="form-control">
                    </div>
                </div>

                <div class="form-group">
                    <label for="orcid">ORCID iD (Opsional)</label>
                    <input type="text" name="orcid" id="orcid" class="form-control" placeholder="https://orcid.org/0000-0000-0000-0000" value="{$orcid|escape|default:''}">
                </div>

                <div class="form-group checkbox-group">
                    <label class="check-label">
                        <input type="checkbox" name="reviewer" value="1" {if $reviewer}checked{/if}>
                        <span>Saya setuju artikel saya dipublikasikan secara akses terbuka di bawah lisensi CC BY 4.0. Ya, daftarkan saya sebagai Mitra Bestari (Reviewer) jika memenuhi syarat.</span>
                    </label>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-lg">
                    Daftar Akun OJS
                </button>
            </form>

            <div class="login-footer">
                <p>Sudah memiliki akun? <a href="{url page="login"}">Masuk di sini</a></p>
            </div>

        </div>
    </div>
</div>

{include file="frontend/components/footer.tpl"}
