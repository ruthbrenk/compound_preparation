# compound_preparation

Note: all scripts are specific to our setup, so will probably need some adjustment to run somewhere else

1) charger.py: apply charger_rules (all subsequent calculations are done with these protonation states) e.g. : charger.py in.sdf out2.smi False 7 0 tests > log_file (you can use cl_charger.py on the cluster, in that case make sure that the correct parameters are set within the script) (you can use use cl_charger_taut.py (), in that case, skip steps 3 and 4)

2) check log_files for errors

3) tautomerizer.py: apply tautomerization rules to output of charger.py e.g : tautomerizer.py out.smi tautomeres_rules.txt out2.smi True > log_file (there is also cl_tautomerizer for the cluster or cl_charger_taut.py to combine this step with 1)

4) check log_files for errors

5) upload to database => mysql_load_unique_smiles.py (if new supplier => add first new supplier to supplier_table) mysql_load_unique_smiles.py

<username>

<password>

<project>

<initial>

6) get compounds out of database to calculate descriptors: mysql_get_smiles_chunks.py, use query_mw_null.txt

step 7,9,11,and 13 can be done with cl_cpd_props.py on the cluster, batches of descriptors can be loaded with batch_load.py

7) calculate descriptors: filter_descriptors.py input.smi out.txt

8) upload descriptors: mysq_load_filter_des.py

9) calculate tpsa with openeye tpsa.py (tpsa.py --i=infile.smi --o=out_file.smi --SandP)

10) upload tpsa with mysql_load_tpsa.py

11) flag certain groups with match_count.py

12) upload with mysql_load_match_count.py

13) calculate unwanted groups with unwanted_groups.py

14) upload unwanted_groups with mysql_load_unwanted_groups.py
