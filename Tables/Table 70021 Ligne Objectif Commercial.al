table 70021 "Ligne Ojectif Commercial"
{
    LookupPageId = "ObjectifCommercial subform";
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No Task"; Code[30])
        {
            DataClassification = ToBeClassified;

        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }



        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Qte Poids"; Decimal)
        {
            Caption = 'Qté Poids';
            DataClassification = ToBeClassified;

        }

        field(5; "Nombre de cartons"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "No Article"; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            TableRelation = if (TypeLigne = const(Categorie)) "Item Category".Code else
            Item."No.";

            trigger OnValidate()
            var
                myInt: Integer;
                item: Record Item;
                "Item Category": Record "Item Category";
                salesPrice: Record "Sales Price";

            begin
                if TypeLigne = TypeLigne::Article then begin
                    item.SetRange("No.", "No Article");
                    if item.FindFirst() then begin
                        Rec."Description" := item.Description;
                        salesPrice.SetRange("Item No.", item."No.");
                        salesPrice.SetRange("Sales Type", salesPrice."Sales Type"::"All Customers");
                        salesPrice.SetRange("Minimum Quantity", 0);

                        if salesPrice.FindFirst() then begin
                            "Prix article" := salesPrice."Unit Price";
                        end;

                    end;
                end else begin
                    "Item Category".SetRange(Code, "No Article");
                    if "Item Category".FindFirst() then begin
                        Rec."Description" := "Item Category".Description;
                    end;
                end;

            end;
        }

        field(7; TypeLigne; Option)
        {
            Caption = 'Type';
            OptionMembers = Categorie,Article;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Clear("No Article");
                Clear(rec.Description);
                Clear(Rec.Pourcentage);
                Clear("Prix article");

            end;

        }
        field(8; "Date debut"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;

        }

        field(9; Prime; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Date fin"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Prix article"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Pourcentage"; Decimal)
        {
            MaxValue = 100;
            MinValue = 0.1;
            DecimalPlaces = 1;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Prime := ((Pourcentage / 100) * "Prix article") * "Qte Poids";
            end;


        }
        field(13; isArticle; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }


    }

    keys
    {
        key(PK; "No Task", "No Article", "Date debut")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        sl: Record "Sales Line";
        editablePourcentage: Boolean;



    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        Rec."Line No" := xRec."Line No";
    end;

    trigger OnRename()
    begin

    end;





    procedure updateNoLine(line: Record "Ligne Ojectif Commercial")
    begin

    end;

}