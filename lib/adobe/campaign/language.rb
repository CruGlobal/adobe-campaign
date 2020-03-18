# frozen_string_literal: true

module Adobe
  module Campaign
    class Language
      def self.map_code(language_code)
        return language_code if language_code.empty?

        code = normalize language_code

        return code if ADOBE_LANGUAGE_CODES.include?(code)

        if code.include?(ADOBE_DELIMITER)
          map_code code.rpartition(ADOBE_DELIMITER).first
        else
          ADOBE_LANGUAGE_CODES.find { |s| s.start_with? code }
        end
      end

      def self.normalize(language_code)
        code = language_code
        code = code.downcase
        code.gsub(ISO_DELIMITER, ADOBE_DELIMITER)
      end

      ISO_DELIMITER = '-'
      ADOBE_DELIMITER = '_'

      #
      # Found at https://cru.campaign.adobe.com/view/home
      # Profiles tab, search, find, and edit a profile, Preferred Lanaguage
      #
      ADOBE_LANGUAGE_CODES = %w[
        af_za
        ar_sa
        ar_ae
        ar_bh
        ar_dz
        ar_eg
        ar_il
        ar_iq
        ar_jo
        ar_kw
        ar_lb
        ar_ly
        ar_ma
        ar_om
        ar_qa
        ar_sy
        ar_tn
        ar_ye
        az_az
        be_by
        bg_bg
        bs_ba
        ca_es
        cs_cz
        da_dk
        de_de
        de_at
        de_be
        de_ch
        de_it
        de_li
        de_lu
        el_gr
        el_cy
        en_us
        en_ae
        en_au
        en_bz
        en_ca
        en_cb
        en_dk
        en_gb
        en_gg
        en_ie
        en_il
        en_im
        en_in
        en_je
        en_jm
        en_kw
        en_my
        en_nz
        en_om
        en_ph
        en_qa
        en_sa
        en_sg
        en_tt
        en_za
        en_zw
        es_es
        es_ar
        es_bo
        es_cl
        es_co
        es_cr
        es_do
        es_ec
        es_gt
        es_hn
        es_mx
        es_ni
        es_pa
        es_pe
        es_pr
        es_py
        es_sv
        es_uy
        es_ve
        et_ee
        eu_es
        fa_ir
        fi_fi
        fo_fo
        fr_fr
        fr_be
        fr_ca
        fr_ch
        fr_lu
        fr_mc
        gl_es
        gu_in
        he_il
        hi_in
        hr_hr
        hu_hu
        hy_am
        id_id
        is_is
        it_it
        it_ch
        ja_jp
        ka_ge
        kk_kz
        kn_in
        ko_kr
        ky_kz
        lt_lt
        lv_lv
        mk_mk
        mn_mn
        mr_in
        ms_my
        ms_bn
        nb_no
        nl_nl
        nl_be
        nn_no
        no_no
        pa_in
        pl_pl
        pt_pt
        pt_br
        ro_ro
        ro_md
        ru_ru
        ru_by
        ru_kz
        ru_ua
        sa_in
        sk_sk
        sl_si
        sq_al
        sq_mk
        sq_xk
        sr_rs
        sr_ba
        sr_xk
        sv_se
        sv_fi
        sw_ke
        ta_in
        te_in
        th_th
        tr_tr
        tr_cy
        tt_ru
        uk_ua
        ur_pk
        ur_in
        uz_uz
        vi_vn
        zh_cn
        zh_hk
        zh_mo
        zh_sg
        zh_tw
      ].freeze
    end
  end
end
