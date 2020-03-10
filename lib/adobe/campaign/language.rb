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
        sq_al
        sq_mk
        sq_xk
        ar_dz
        ar_bh
        ar_eg
        ar_iq
        ar_il
        ar_jo
        ar_kw
        ar_lb
        ar_ly
        ar_ma
        ar_om
        ar_qa
        ar_sa
        ar_sy
        ar_tn
        ar_ae
        ar_ye
        hy_am
        az_az
        eu_es
        be_by
        bs_ba
        bg_bg
        ca_es
        zh_cn
        zh_sg
        zh_hk
        zh_mo
        zh_tw
        hr_hr
        cs_cz
        da_dk
        nl_be
        nl_nl
        en_us
        en_au
        en_bz
        en_ca
        en_cb
        en_dk
        en_gg
        en_in
        en_ie
        en_il
        en_im
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
        en_za
        en_tt
        en_ae
        en_gb
        en_zw
        et_ee
        fo_fo
        fa_ir
        fi_fi
        fr_be
        fr_ca
        fr_fr
        fr_lu
        fr_mc
        fr_ch
        gl_es
        ka_ge
        de_at
        de_be
        de_de
        de_it
        de_li
        de_lu
        de_ch
        el_cy
        el_gr
        gu_in
        he_il
        hi_in
        hu_hu
        is_is
        id_id
        it_it
        it_ch
        ja_jp
        kn_in
        kk_kz
        ko_kr
        ky_kz
        lv_lv
        lt_lt
        mk_mk
        ms_bn
        ms_my
        mr_in
        mn_mn
        nb_no
        nn_no
        no_no
        pl_pl
        pt_br
        pt_pt
        pa_in
        ro_md
        ro_ro
        ru_by
        ru_kz
        ru_ru
        ru_ua
        sa_in
        sr_ba
        sr_rs
        sr_xk
        sk_sk
        sl_si
        es_ar
        es_bo
        es_cl
        es_co
        es_cr
        es_do
        es_ec
        es_sv
        es_gt
        es_hn
        es_mx
        es_ni
        es_pa
        es_py
        es_pe
        es_pr
        es_es
        es_uy
        es_ve
        sw_ke
        sv_fi
        sv_se
        ta_in
        tt_ru
        te_in
        th_th
        tr_cy
        tr_tr
        uk_ua
        ur_in
        ur_pk
        uz_uz
        vi_vn
      ].freeze
    end
  end
end
