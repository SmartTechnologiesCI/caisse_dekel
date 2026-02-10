table 70029 Entete_Paiement
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; code_Paiement; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(50001; Palanteur; code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Planteur';
            TableRelation = Vendor;
            trigger OnValidate()
            var
                myInt: Integer;
                Souche: Record Souche;
            begin
                AssistEdit_PointCaisse(xRec);
                Souche.Reset();
                Souche.Init();
                Souche.User := UserId;
                Souche.Code_Souche := NumDocExt;
                Souche.Insert();
            end;
        }
        field(50002; Date_Paiement; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Beneficiare; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Caissier; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Caissier/Caissière';
            Editable = false;
        }
        field(50005; Code_Transporteur; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code transporteur';
        }
        field(5006; Nom_Transporteur; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nom Transporteur';
        }
        field(5007; Nom_Planteur; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nom planteur';
        }
        field(50008; NumDocExt; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Document';
            Editable = false;
        }
        field(50029; CNI; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Pièce';
        }
        field(50030; Mode_Paiement; Option)
        {
            Caption = 'Mode Paiement';
            DataClassification = ToBeClassified;
            OptionMembers = " ",ESPECE,WAVE,OM,"MTN Money","MOOV Money",CHEQUE;
        }
        field(50031; Observation; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; Telephone; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; Archive; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Archivé';
        }
        field(50034; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55010; TotalPlanteur; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat planteur';
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
                ParaCaisse: Record "Parametres caisse";
            begin
                // ParaCaisse.Reset();
                // ParaCaisse.Get();
                // rec.Impot:=ParaCaisse.PoucentageImpot*
            end;
        }
        field(55011; Impot; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Impôt 1,5 %';
            Editable = false;
        }
        field(55012; TotalPlanteurTTc; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat planteur(TTC:) FCFA';
            Editable = false;
        }

        field(55014; Poids_Total; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Poids Total (KG)';
            Editable = false;
        }
        field(55015; PrixUnitaire; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Prix unitaire (FCFA)';
        }

        //**
        field(55016; TotalPlanteurTTc2; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Total Achat planteur(TTC:) FCFA';
            Editable = false;
            CalcFormula = sum("Item Weigh Bridge".TotalPlanteurTTc where(NumDocExten = field(NumDocExt), "Statut paiement Planteur" = const(true)));
        }

        field(55017; Poids_Total2; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Poids Total (KG)';
            Editable = false;
            CalcFormula = sum("Item Weigh Bridge"."POIDS NET" where(NumDocExten = field(NumDocExt), "Statut paiement Planteur" = const(true)));
        }
        field(55018; TotalPlanteur2; Decimal)
        {


            Caption = 'Total Achat planteur (FCFA)';
            FieldClass = FlowField;
            CalcFormula = sum("Item Weigh Bridge".TotalPlanteur where(NumDocExten = field(NumDocExt), "Statut paiement Planteur" = const(true)));

        }
        field(55019; NaturePiece; Option)
        {
            Caption = 'Nature pièce';
            OptionMembers = CNI,PASSEPORT,PERMIS,CS,AUTRES;
        }
        field(55020; TotalRegimeTTC; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Total Planteur (TTC)';
            Editable = false;
            CalcFormula = sum("Item Weigh Bridge".TotalPlanteurTTc where(NumDocExten = field(NumDocExt)));

        }
        field(55021; TotalRegime; Decimal)
        {
            Caption = 'Total Planteur(HT)';
            FieldClass = FlowField;
            CalcFormula = sum("Item Weigh Bridge".TotalPlanteur where(NumDocExten = field(NumDocExt)));

        }
        field(55022; TotalRegimeIMPOT; Decimal)
        {
            Caption = 'Impôt (%)';
            FieldClass = FlowField;
            CalcFormula = sum("Item Weigh Bridge".Impot where(NumDocExten = field(NumDocExt), Ticket_Concerne = const(true)));

        }
        field(55023; PoidTotalRegime; Decimal)
        {
            Caption = 'Poids total (KG)';
            FieldClass = FlowField;
            CalcFormula = sum("Item Weigh Bridge"."POIDS NET" where(NumDocExten = field(NumDocExt), Ticket_Concerne = const(true)));

        }
        field(55024; StatutAnnulaition; Boolean)
        {
            Caption = 'Annulé';
            DataClassification = ToBeClassified;
        }
        field(55025; CLPaiement; code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Centre Logistique';
        }
        field(55026; DescriptionCL; code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description CL';
        }


    }


    keys
    {
        key(Key1; code_Paiement, NumDocExt)
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
        // Add changes to field groups here
    }
    procedure AssistEdit_PointCaisse(OldPoint: Record Entete_Paiement): Boolean;
    var
        Balance: Record "Parametres caisse";
        TicketPlanteur: Code[100];
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        // Vérifier qu'une balance est sélectionnée
        // Rec.TestField(NU);
        Balance.Get();
        // Balance.SetRange(Code, Rec."Balance Code");
        if not Balance.FindFirst() then
            Error('Renseignement la souche de numéro paie ticket dans paramètre utilisateurs.');
        if NoSeriesMgt.SelectSeries(Balance.NumSouschPaie, OldPoint."No. Series", Rec."No. Series") then begin

            TicketPlanteur :=
                NoSeriesMgt.GetNextNo(Rec."No. Series", WorkDate(), true);

            Rec.NumDocExt := TicketPlanteur;

            exit(true);
        end else begin
            Error('Impossible de sélectionner la souche de numérotation "%1".', Balance.NumSouschPaie);
        end;
    end;

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