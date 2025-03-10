table 70018 "Ajustement Stock"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N°';
            trigger OnValidate()
            begin
                if rec."No." <> xRec."No." then begin
                    PStock.Get();
                    // NoSeriesMgt.TestManual(PStock."N° Ajustement");
                    rec."No. Series" := '';
                    /*if xRec."No Point" = '' then
                        "Costing Method" := InvtSetup."Default Costing Method";*/
                end;
            end;
        }
        field(2; "Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Positif,Négatif,Inventaire';
            OptionMembers = "Positif","Negatif","Inventaire";
        }
        field(3; "Document Date"; Date)
        {
            Caption = 'Date de document';
            DataClassification = ToBeClassified;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Date de comptabilisation';
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; Code[30])
        {
            Caption = 'N° Article';
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
        }
        field(6; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; "Location Code"; Code[30])
        {
            Caption = 'Code magasin';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(8; "Nombre Cartons"; Integer)
        {
            Caption = 'Nombre de cartons';
            DataClassification = ToBeClassified;
        }
        field(9; "Quantité"; Decimal)
        {
            Caption = 'Poids';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 3;
        }
        field(10; "curr Carton"; Integer)
        {
            Caption = 'Cartons actuels';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "curr Quantity"; Decimal)
        {

            Caption = 'Poids Actuel';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Posted"; Boolean)
        {
            Caption = 'Validé';
            DataClassification = ToBeClassified;
        }
        field(16; "No. Series"; Code[20])
        {
            CaptionML = ENU = 'No. Series',
                        FRA = 'N° Séries';
            Editable = false;
        }

        field(17; "curr Carton Mag"; Integer)
        {
            Caption = 'Cartons actuels du magasin';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "curr Quantity Mag"; Decimal)
        {

            Caption = 'Poids Actuel du magasin';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        PStock: Record 313;
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PStock.get();
            // SILUE SAMPStock.TestField("N° Ajustement");
            // NoSeriesMgt.InitSeries(PStock."N° Ajustement", xRec."No. Series", 0D, "No.", "No. Series");
        end;
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