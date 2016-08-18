# -*- coding: utf-8 -*- This line is just for your information, the python plugin will not use the first line
# insert on gvflode write to updated
CREATE TRIGGER "tai_gvflode_updated" AFTER INSERT ON "gvflode" WHEN (0 < (select count() from "gvflode" where ((NEW.updated is null) AND (NEW.geometry is not NULL)))) BEGIN UPDATE gvflode SET  updated = datetime('now','localtime') WHERE (NEW.updated is null) AND (NEW.geometry is not NULL) AND (NEW.pkuid = pkuid); END;
# update on gvflode write to updated
# HÄR FINNS INTERMAG MED OCH DET BORDE VARA MED MEN AVNÅGON ANLEDNIBNG KRASCHAR DET DÅ
CREATE TRIGGER "tau_gvflode_updated" AFTER UPDATE ON "gvflode" WHEN (0 < (select count() from "gvflode" where (NEW.namn != OLD.namn or NEW.typ != OLD.typ or NEW.ursprung != OLD.ursprung or NEW.kommentar != OLD.kommentar or NEW.geometry != OLD.geometry or NEW.intermag != OLD.intermag or (NEW.namn is not null and OLD.namn is null)  or (NEW.typ is not null and OLD.typ is null) or (NEW.ursprung is not null and OLD.ursprung is null) or (NEW.kommentar is not null and OLD.kommentar is null)  or (NEW.intermag is not null and OLD.intermag is null))) ) BEGIN update gvflode SET updated = datetime('now','localtime') WHERE ((NEW.namn != OLD.namn or NEW.typ != OLD.typ or NEW.ursprung != OLD.ursprung or NEW.kommentar != OLD.kommentar or NEW.geometry != OLD.geometry or NEW.intermag != OLD.intermag or (NEW.namn is not null and OLD.namn is null)  or (NEW.typ is not null and OLD.typ is null) or (NEW.ursprung is not null and OLD.ursprung is null) or (NEW.kommentar is not null and OLD.kommentar is null)  or (NEW.intermag is not null and OLD.intermag is null) ) and  (NEW.pkuid = pkuid)); END;
# insert on gvdel write to updated
CREATE TRIGGER "tai_gvdel_updated" AFTER INSERT ON "gvdel" WHEN (0 < (select count() from "gvdel" where ((NEW.updated is null) AND (NEW.geometry is not NULL)))) BEGIN UPDATE gvdel SET  updated = datetime('now','localtime') WHERE (NEW.updated is null) AND (NEW.geometry is not NULL) AND (NEW.pkuid = pkuid); END;
# update on gvdel write to updated
CREATE TRIGGER "tau_gvdel_updated" AFTER UPDATE ON "gvdel" WHEN (0 < (select count() from "gvdel" where (NEW.namn != OLD.namn or NEW.typ != OLD.typ or NEW.ursprung != OLD.ursprung or NEW.kommentar != OLD.kommentar or NEW.geometry != OLD.geometry or (NEW.namn is not null and OLD.namn is null)  or (NEW.typ is not null and OLD.typ is null) or (NEW.ursprung is not null and OLD.ursprung is null) or (NEW.kommentar is not null and OLD.kommentar is null) )) ) BEGIN update gvdel SET updated = datetime('now','localtime') WHERE ((NEW.namn != OLD.namn or NEW.typ != OLD.typ or NEW.ursprung != OLD.ursprung or NEW.kommentar != OLD.kommentar or NEW.geometry != OLD.geometry or (NEW.namn is not null and OLD.namn is null)  or (NEW.typ is not null and OLD.typ is null) or (NEW.ursprung is not null and OLD.ursprung is null) or (NEW.kommentar is not null and OLD.kommentar is null)  ) and  (NEW.pkuid = pkuid));  END;
# insert on gvmag write to updated
CREATE TRIGGER "tai_gvmag_updated" AFTER INSERT ON "gvmag" WHEN (0 < (select count() from "gvmag" where ((NEW.updated is null) AND (NEW.geometry is not NULL)))) BEGIN UPDATE gvmag SET  updated = datetime('now','localtime') WHERE ((NEW.updated is null) AND (NEW.geometry is not NULL) AND (NEW.pkuid = pkuid)); END;
# update on gvmag write to updated
CREATE TRIGGER "tau_gvmag_updated" AFTER UPDATE ON "gvmag" WHEN (0 < (select count() from "gvmag" where (NEW.namn != OLD.namn or NEW.typ != OLD.typ or NEW.ursprung != OLD.ursprung or NEW.kommentar != OLD.kommentar or NEW.geometry != OLD.geometry or (NEW.namn is not null and OLD.namn is null)  or (NEW.typ is not null and OLD.typ is null) or (NEW.ursprung is not null and OLD.ursprung is null) or (NEW.kommentar is not null and OLD.kommentar is null))) ) BEGIN update gvmag SET updated = datetime('now','localtime') WHERE ((NEW.namn != OLD.namn or NEW.typ != OLD.typ or NEW.ursprung != OLD.ursprung or NEW.kommentar != OLD.kommentar or NEW.geometry != OLD.geometry or (NEW.namn is not null and OLD.namn is null)  or (NEW.typ is not null and OLD.typ is null) or (NEW.ursprung is not null and OLD.ursprung is null) or (NEW.kommentar is not null and OLD.kommentar is null) ) and  (NEW.pkuid = pkuid)); END;
# insert on tillromr write to updated
CREATE TRIGGER "tai_tillromr_updated" AFTER INSERT ON "tillromr" WHEN (0 < (select count() from "tillromr" where ((NEW.updated is null) AND (NEW.geometry is not NULL)))) BEGIN UPDATE tillromr SET  updated = datetime('now','localtime') WHERE ((NEW.updated is null) AND (NEW.geometry is not NULL) AND (NEW.pkuid = pkuid)); END;
# insert on tillromr write to "area_km2"
CREATE TRIGGER "tai_tillromr_area_km2" AFTER INSERT ON "tillromr" WHEN (0 < (select count() from "tillromr" where ((NEW.area_km2 is null) AND (NEW.geometry is not NULL)))) BEGIN UPDATE tillromr SET area_km2 = round(ST_Area(geometry)/1000000.0,2) WHERE ((NEW.area_km2 is null) AND (NEW.geometry is not NULL) AND (NEW.pkuid = pkuid)); END;
# insert on tillromr write to "andel_t_mag_proc"
CREATE TRIGGER "tai_tillromr_andel_t_mag_proc" AFTER INSERT ON "tillromr" WHEN (0 < (select count() from "tillromr" where ((NEW.geometry is not NULL) AND NEW.typ is not null and (NEW.typ='a' or NEW.typ='b')))) BEGIN update tillromr SET andel_t_mag_proc = 100.0 WHERE pkuid = NEW.pkuid and ((NEW.geometry is not NULL) AND NEW.typ is not null and (NEW.typ='a' or NEW.typ='b')); END
# update on tillromr write to updated
CREATE TRIGGER "tau_tillromr_updated" AFTER UPDATE ON "tillromr" WHEN (0 < (select count() from "tillromr" where (NEW.namn != OLD.namn or NEW.typ != OLD.typ or NEW.gvbildn_mm !=OLD.gvbildn_mm or NEW.andel_t_mag_proc != OLD.andel_t_mag_proc or NEW.ursprung != OLD.ursprung or NEW.kommentar != OLD.kommentar or NEW.geometry != OLD.geometry or (NEW.namn is not null and OLD.namn is null)  or (NEW.typ is not null and OLD.typ is null) or (NEW.gvbildn_mm is not null and OLD.gvbildn_mm is null) or (NEW.andel_t_mag_proc is not null and OLD.andel_t_mag_proc is null)  or (NEW.ursprung is not null and OLD.ursprung is null) or (NEW.kommentar is not null and OLD.kommentar is null))) ) BEGIN update tillromr SET updated = datetime('now','localtime') WHERE (((NEW.namn != OLD.namn or NEW.typ != OLD.typ or NEW.gvbildn_mm !=OLD.gvbildn_mm or NEW.andel_t_mag_proc != OLD.andel_t_mag_proc or NEW.ursprung != OLD.ursprung or NEW.kommentar != OLD.kommentar or NEW.geometry != OLD.geometry or (NEW.namn is not null and OLD.namn is null)  or (NEW.typ is not null and OLD.typ is null) or (NEW.gvbildn_mm is not null and OLD.gvbildn_mm is null) or NEW.andel_t_mag_proc is not null and OLD.andel_t_mag_proc is null) or (NEW.ursprung is not null and OLD.ursprung is null) or (NEW.kommentar is not null and OLD.kommentar is null) ) and  (NEW.pkuid = pkuid)); END;
# update on tillromr write to "area_km2"
CREATE TRIGGER "tau_tillromr_area_km2" AFTER UPDATE ON "tillromr" WHEN (0 < (select count() from "tillromr" where NEW.geometry != OLD.geometry)) BEGIN update tillromr SET area_km2 = round(ST_Area(geometry)/1000000.0,2) WHERE NEW.geometry != OLD.geometry; END;
# update on tillromr write to "flode_lPs"
CREATE TRIGGER "tau_tillromr_flode_lPs" AFTER UPDATE ON "tillromr" WHEN (0 < (select count() from "tillromr" where (NEW.gvbildn_mm !=OLD.gvbildn_mm or NEW.andel_t_mag_proc != OLD.andel_t_mag_proc or NEW.area_km2 != OLD.area_km2 or (NEW.gvbildn_mm is not null and OLD.gvbildn_mm is null) or (NEW.andel_t_mag_proc is not null and OLD.andel_t_mag_proc is null) or (NEW.area_km2 is not null and OLD.area_km2 is null)))) BEGIN update tillromr SET flode_lPs = round(ST_Area(geometry)*(gvbildn_mm/(365*24*3600))*andel_t_mag_proc/100.0,1) WHERE (NEW.gvbildn_mm !=OLD.gvbildn_mm or NEW.andel_t_mag_proc != OLD.andel_t_mag_proc or NEW.area_km2 != OLD.area_km2 or (NEW.gvbildn_mm is not null and OLD.gvbildn_mm is null) or (NEW.andel_t_mag_proc is not null and OLD.andel_t_mag_proc is null) or (NEW.area_km2 is not null and OLD.area_km2 is null) and (NEW.gvbildn_mm is not null and NEW.andel_t_mag_proc is not null and NEW.area_km2 is not null));END;
# update on tillromr write to "andel_t_mag_proc"
CREATE TRIGGER "tau_tillromr_andel_t_mag_proc" AFTER UPDATE OF "typ" ON "tillromr" WHEN  (0 < (select count() from "tillromr" where ((NEW.typ ='a' != OLD.typ != 'a') or (NEW.typ ='b' != OLD.typ != 'b') or ((NEW.typ ='a' or NEW.typ ='b') and OLD.typ is null))))  BEGIN  update tillromr SET andel_t_mag_proc = 100.0 WHERE (typ = 'a' or typ = 'b') and pkuid=NEW.pkuid; END
