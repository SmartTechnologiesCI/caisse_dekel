table 70015 "situation caisse"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "code"; code[30])
        {
            DataClassification = ToBeClassified;

        }

        field(2; encaissementEspeceCaisse1; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Date = field(dateFilter), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('ESPÈCES'), Source = const(Facture), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }

        field(3; encaissementVirementCaisse1; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(date = field(dateFilter), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('VIREMENT'), Source = const(Facture), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }
        field(4; encaissementCHEQUECaisse1; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(date = field(dateFilter), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('CHEQUE'), Source = const(Facture), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }
        field(5; encaissementDepotCaisse1; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Date = field(dateFilter), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('EPARGNE'), Source = const(Facture), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }
        field(6; depotEspeceCaisse1; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('ESPÈCES')));
        }
        field(7; depotVirementCaisse1; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('VIREMENT')));
        }
        field(8; depotChequeCaisse1; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('CHEQUE')));
        }
        field(9; "entreeCaisse1"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Mouvement entrees et sorties';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const("E/S"), date = field(dateFilter), "Code caisse" = const('CAISSE1'), Montant = field(montangFilter1)));
        }
        field(10; "sortieCaisse1"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Mouvement entrees et sorties';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const("E/S"), date = field(dateFilter), "Code caisse" = const('CAISSE1'), Montant = field(montangFilter2)));
        }

        field(11; encaissementEspeceCaisse2; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Encaissements';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(source = const(Facture), Date = field(dateFilter), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('ESPÈCES'), recouvrement = const(false)));
        }

        field(69; encaissementEspeceCaisse3; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Encaissements';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(source = const(Facture), Date = field(dateFilter), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('ESPÈCES'), recouvrement = const(false)));
        }

        field(12; encaissementVirementCaisse2; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(date = field(dateFilter), Source = const(Facture), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('VIREMENT'), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }
        field(68; encaissementVirementCaisse3; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(date = field(dateFilter), Source = const(Facture), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('VIREMENT'), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }
        field(13; encaissementCHEQUECaisse2; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(date = field(dateFilter), Source = const(Facture), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('CHEQUE'), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }

        field(67; encaissementCHEQUECaisse3; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(date = field(dateFilter), Source = const(Facture), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('CHEQUE'), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }
        field(14; encaissementDepotCaisse2; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Date = field(dateFilter), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('EPARGNE'), Source = const(Facture), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }

         field(66; encaissementDepotCaisse3; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Date = field(dateFilter), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('EPARGNE'), Source = const(Facture), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }
        field(15; depotEspeceCaisse2; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('ESPÈCES')));
        }

         field(65; depotEspeceCaisse3; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('ESPÈCES')));
        }
        field(16; depotVirementCaisse2; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('VIREMENT')));
        }

        field(64; depotVirementCaisse3; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('VIREMENT')));
        }
        field(17; depotChequeCaisse2; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('CHEQUE')));
        }

         field(63; depotChequeCaisse3; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('CHEQUE')));
        }
        field(18; "entreeCaisse2"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Mouvements  entrees et sorties';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const("E/S"), date = field(dateFilter), "Code caisse" = const('CAISSE2'), Montant = field(montangFilter1)));
        }

         field(62; "entreeCaisse3"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Mouvements  entrees et sorties';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const("E/S"), date = field(dateFilter), "Code caisse" = const('CAISSE3'), Montant = field(montangFilter1)));
        }
        field(19; "sortieCaisse2"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Mouvements  entrees et sorties';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const("E/S"), date = field(dateFilter), "Code caisse" = const('CAISSE2'), Montant = field(montangFilter2)));
        }

         field(61; "sortieCaisse3"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Mouvements  entrees et sorties';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const("E/S"), date = field(dateFilter), "Code caisse" = const('CAISSE3'), Montant = field(montangFilter3)));
        }
        field(20; "Total espece caisse1"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total espèce caisse1';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where("Mode de reglement" = const('ESPÈCES'), date = field(dateFilter), "Code caisse" = const('CAISSE1')));
        }
        field(21; "Total espece caisse2"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total espèce caisse 2';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where("Mode de reglement" = const('ESPÈCES'), date = field(dateFilter), "Code caisse" = const('CAISSE2')));
        }

         field(60; "Total espece caisse3"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total espèce caisse 3';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where("Mode de reglement" = const('ESPÈCES'), date = field(dateFilter), "Code caisse" = const('CAISSE3')));
        }
        field(22; "Montant declare caisse1"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total espèce caisse 1';
            FieldClass = FlowField;
            CalcFormula = sum("Ouverture de caisse"."Montant clôture" where("Date ouverture" = field(dateFilter), "Code caisse" = const('CAISSE1')));
        }
        field(23; "Montant declare caisse2"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total espèce caisse 2';
            FieldClass = FlowField;
            CalcFormula = sum("Ouverture de caisse"."Montant clôture" where("Date ouverture" = field(dateFilter), "Code caisse" = const('CAISSE2')));
        }

         field(59; "Montant declare caisse3"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total espèce caisse 3';
            FieldClass = FlowField;
            CalcFormula = sum("Ouverture de caisse"."Montant clôture" where("Date ouverture" = field(dateFilter), "Code caisse" = const('CAISSE3')));
        }
        field(24; "Fond de caisse1"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Font de caisse';
            //FieldClass = FlowField;
            //CalcFormula = sum("Ouverture de caisse".Amount where("Date ouverture" = field(dateFilter), "Code caisse" = const('CAISSE1')));
        }
        field(25; "Fond de caisse2"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Font de caisse';
            //FieldClass = FlowField;
            //CalcFormula = sum("Ouverture de caisse".Amount where("Date ouverture" = field(dateFilter), "Code caisse" = const('CAISSE2')));
        }

         field(58; "Fond de caisse3"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Font de caisse';
            //FieldClass = FlowField;
            //CalcFormula = sum("Ouverture de caisse".Amount where("Date ouverture" = field(dateFilter), "Code caisse" = const('CAISSE2')));
        }
        field(26; dateFilter; date)
        {
            FieldClass = FlowFilter;
        }
        field(32; montangFilter1; decimal)
        {
            FieldClass = FlowFilter;
        }
        field(33; montangFilter2; decimal)
        {
            FieldClass = FlowFilter;
        }
         field(48; montangFilter3; decimal)
        {
            FieldClass = FlowFilter;
        }
        field(28; encaissementCaisse1; Decimal)
        {
            FieldClass = FlowField;
            //CalcFormula = sum(Encaissement."Montant NET" where(date = field(dateFilter), "Code caisse" = const('CAISSE1')));
            CalcFormula = sum(Transactions."Montant NET" where(Date = field(dateFilter), "Code caisse" = const('CAISSE1'), Source = const(Facture), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }
        field(29; encaissementCaisse2; Decimal)
        {
            FieldClass = FlowField;
            //CalcFormula = sum(Encaissement."Montant NET" where(date = field(dateFilter), "Code caisse" = const('CAISSE2')));
            CalcFormula = sum(Transactions."Montant NET" where(Date = field(dateFilter), "Code caisse" = const('CAISSE2'), Source = const(Facture), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }

         field(49; encaissementCaisse3; Decimal)
        {
            FieldClass = FlowField;
            //CalcFormula = sum(Encaissement."Montant NET" where(date = field(dateFilter), "Code caisse" = const('CAISSE2')));
            CalcFormula = sum(Transactions."Montant NET" where(Date = field(dateFilter), "Code caisse" = const('CAISSE3'), Source = const(Facture), recouvrement = const(false)));
            AutoFormatType = 1;
            Caption = 'Encaissements';
        }
        field(30; depotCaisse1; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE1')));
        }
        field(31; depotCaisse2; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE2')));
        }

          field(50; depotCaisse3; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field(dateFilter), "Code caisse" = const('CAISSE3')));
        }
        field(34; RecouvrementEspececaisse1; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement espèce';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('ESPÈCES'), Date = field(dateFilter)));
        }
        field(35; RecouvrementEspececaisse2; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement espèce';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('ESPÈCES'), Date = field(dateFilter)));
        }

        field(51; RecouvrementEspececaisse3; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement espèce';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('ESPÈCES'), Date = field(dateFilter)));
        }
        field(36; Recouvrementdepotcaisse1; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('EPARGNE'), Date = field(dateFilter)));
        }
        field(37; Recouvrementdepotcaisse2; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('EPARGNE'), Date = field(dateFilter)));
        }

        field(52; Recouvrementdepotcaisse3; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('EPARGNE'), Date = field(dateFilter)));
        }
        field(38; RecouvrementVIREMENTcaisse1; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement virement';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('VIREMENT'), Date = field(dateFilter)));
        }
        field(39; RecouvrementVIREMENTcaisse2; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement virement';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('VIREMENT'), Date = field(dateFilter)));
        }

         field(53; RecouvrementVIREMENTcaisse3; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement virement';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('VIREMENT'), Date = field(dateFilter)));
        }
        field(40; RecouvrementCHEQUEcaisse1; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement Chèques';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE1'), "Mode de reglement" = const('CHEQUE'), Date = field(dateFilter)));
        }
        field(41; RecouvrementCHEQUEcaisse2; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement Chèques';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE2'), "Mode de reglement" = const('CHEQUE'), Date = field(dateFilter)));
        }

         field(54; RecouvrementCHEQUEcaisse3; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement Chèques';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE3'), "Mode de reglement" = const('CHEQUE'), Date = field(dateFilter)));
        }
        field(42; Recouvrementcaisse1; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE1'), Date = field(dateFilter)));
        }
        field(43; Recouvrementcaisse2; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE2'), Date = field(dateFilter)));
        }

          field(55; Recouvrementcaisse3; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recouvrement';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), "Code caisse" = const('CAISSE3'), Date = field(dateFilter)));
        }
        field(44; "Espece attendu caisse1"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Espèce attendu';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where("Code caisse" = const('CAISSE1'), "Mode de reglement" = const('ESPÈCES'), Date = field(dateFilter)));
        }
        field(45; "Espece attendu caisse2"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Espèce attendu';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where("Code caisse" = const('CAISSE2'), "Mode de reglement" = const('ESPÈCES'), Date = field(dateFilter)));
        }

         field(56; "Espece attendu caisse3"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Espèce attendu';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where("Code caisse" = const('CAISSE3'), "Mode de reglement" = const('ESPÈCES'), Date = field(dateFilter)));
        }
        field(46; "Espece declare caisse1"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Espèce déclaré';
            FieldClass = FlowField;
            CalcFormula = sum("Ouverture de caisse"."Montant clôture" where("Date ouverture" = field(dateFilter), "Code caisse" = const('CAISSE1')));
        }
        field(47; "Espece declaré caisse2"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Espèce déclaré';
            FieldClass = FlowField;
            CalcFormula = sum("Ouverture de caisse"."Montant clôture" where("Date ouverture" = field(dateFilter), "Code caisse" = const('CAISSE2')));
        }

         field(57; "Espece declaré caisse3"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Espèce déclaré';
            FieldClass = FlowField;
            CalcFormula = sum("Ouverture de caisse"."Montant clôture" where("Date ouverture" = field(dateFilter), "Code caisse" = const('CAISSE3')));
        }
    }

    keys
    {
        key(PK; code)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}