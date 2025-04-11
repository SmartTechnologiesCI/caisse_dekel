table 70011 "Caisse Cue"
{
   

    fields
    {
        field(1; id; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Factures du jour"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purch. Inv. Header" where(Closed = const(false), "Order Date" = field("Date Filter")));
        }
        field(3; "Factures anterieures"; integer)
        {
            
            CalcFormula = count("Purch. Inv. Header" where(closed = const(false)));
            FieldClass = FlowField;
            Editable=false;
            
            
        }
        field(4; "Factures à crédit"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where(CreditP = const(true), "Remaining Amount" = filter('>0')));
        }
        field(5; "Depots du jour"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Depôt" where(date = field("Date Filter"), "Code Caisse" = field("caisse filter"), Montant = filter('>0')));
        }
        field(17; "Depots Actifs"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Dépôts" = filter('>0'), "do epargne" = const(false)));
        }
        field(6; "Total entrées du jours"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Mouvements Entrees Sorties".Montant where(date = field("Date Filter"), "Code Caisse" = field("caisse filter"), type = const(Entree)));

        }
        field(7; "Total sorties du jours"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Mouvements Entrees Sorties".Montant where(date = field("Date Filter"), "Code Caisse" = field("caisse filter"), type = const(Sortie)));
        }
        field(8; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(9; "caisse filter"; Code[30])
        {
            FieldClass = FlowFilter;
        }
        field(10; "date filter 2"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(11; "debiteur"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Balance Due" = field(balanceFilter)));
        }
        field(12; "crediteur"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Balance Due" = field(balanceFilter2)));
        }
        field(13; "balanceFilter"; integer)
        {
            FieldClass = FlowFilter;
        }
        field(14; "balanceFilter2"; integer)
        {
            FieldClass = FlowFilter;
        }
        field(15; "Factures pécommandées"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where(Closed = const(false), "Order Date" = field("date filter 3")));
        }
        field(16; "date filter 3"; Date)
        {
            FieldClass = FlowFilter;
        }

        field(18; "DepotsCorrectionAttente"; integer)
        {
            FieldClass = FlowField;
            // silue samuel 07/03/2025 CalcFormula = count("Depôt" where("Code Caisse" = field("caisse filter"), DemandeApprobation = const(true), Correction = const(false), validated = const(false)));
        }
        field(19; "DepotsCorrectionApprou"; integer)
        {
            FieldClass = FlowField;
            // silue samuel 07/03/2025 CalcFormula = count("Depôt" where("Code Caisse" = field("caisse filter"), DemandeApprobation = const(true), Correction = const(True), validated = const(false)));
        }

        // silue samuel 07/03/2025 field(20; "DuplicataAttente"; integer)
        // {
        //     FieldClass = FlowField;
        //     // silue samuel 07/03/2025 CalcFormula = count("Sales Invoice Header" where("Demande approbation" = const(true), Approuve = const(false)));
        // }
        field(21; "DuplicataApprou"; integer)
        {
            FieldClass = FlowField;
            // CalcFormula = count("Sales Invoice Header" where(Approuve = const(true)));
        }
    }


    keys
    {
        key(PK; id)
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