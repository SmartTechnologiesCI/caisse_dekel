table 70014 "Director Cue"
{
    DataClassification = ToBeClassified;
    //ColumnStoreIndex="Total Ventes du jours";
    fields
    {
        field(1; id; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Factures du jour"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where(Closed = const(false), "Order Date" = field("Date Filter"), "Statut Livraison" = const("Non payée")));
        }
        field(3; "Factures anterieures"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where(Closed = const(false), "Order Date" = field("date filter 2")));
        }
        field(4; "Factures à crédit"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where(CreditP = const(true), Closed = const(false)));
        }
        field(5; "Depots du jour"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Depôt" where(date = field("Date Filter"), "Code Caisse" = field("caisse filter")));
        }
        field(6; "Total Ventes du jours"; Decimal)
        {
            //FieldClass = FlowField;
            // CalcFormula = sum("Sales Invoice Header"."Amount Including VAT" where("Order Date" = field("Date Filter")));

        }
        field(7; "Total Transactions du jours"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(date = field("Date Filter")));
        }
        field(15; "Total Espèces du jours"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(date = field("Date Filter"), "Mode de reglement" = const('ESPÈCES')));
        }
        field(8; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(9; "caisse filter"; code[20])
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
            CalcFormula = count(Customer where("Dépôts" = filter('>0')));

        }
        field(12; "crediteur"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Dépôts" = filter('>0')));
        }
        field(13; "balanceFilter"; integer)
        {
            FieldClass = FlowFilter;
        }
        field(14; "balanceFilter2"; integer)
        {
            FieldClass = FlowFilter;
        }
        field(16; "Commandes prix à fixer"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Prix fixé" = const(false), ETA = field("date filter 3"), "Fixation des prix" = const(true)));
        }
        field(17; "Depots Actifs"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Depôt" where(Date = field("Date Filter"), Montant = filter('>0')));
        }
        field(18; "date filter 3"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(19; "Commande en cours"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where(Status = const(Open), "Document Type" = const(Order), "Order Date" = field("Date Filter")));
        }

        field(20; "Available items"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Item where(Inventory = filter('>0')));
        }
        field(21; "Total crédits en cours"; Decimal)
        {
        }
        field(22; "Total des entrées"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Mouvements Entrees Sorties".Montant where(type = const(Entree), Date = field("Date Filter")));
        }
        field(23; "Total des sorties"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Mouvements Entrees Sorties".Montant where(type = const(Sortie), Date = field("Date Filter")));
        }
        field(24; "Total dépôts"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Totals dépôts';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Depot), date = field("Date Filter")));
        }
        field(25; "Total recouvrement"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total recouvrement';
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where(Source = const(Facture), recouvrement = const(true), Date = field("Date Filter")));
        }
        field(26; "Non Payées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("Non Payée"), "Posting Date" = field(dateFilter)));
        }
        field(27; "Payées Non livrées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("Payée non livré")));

        }
        field(28; "Payées partiellement livrées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("Payée partiellement livré"), "Posting Date" = field(dateFilter)));
        }
        field(29; "Payées totalement livrées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("Payée totalement livré"), "Posting Date" = field(dateFilter)));
        }
        field(33; "Factures douanieres"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where("Est Echantillone" = const(true), "Due Date" = field(dateFilter)));
        }
        /*field(30; "Non payées totalement livrées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("Non payée totalement livré"), "Document Date" = field(dateFilter)));

        }
        field(31; "Non payées partiel. livrées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("non payée partiellement livré"), "Document Date" = field(dateFilter)));
        }*/
        field(32; dateFilter; date)
        {
            FieldClass = FlowFilter;
        }
        field(34; "Article paye non livre"; Integer)
        {
            FieldClass = FlowField;
            //CalcFormula = count("Sales Invoice Line" Where("Statut Livraison" = const("Payée non livré")));
            //SourceTableView = where("Statut Livraison" = filter('=Payée Non livré|Payée partiellement livré'));
            // CalcFormula = count(Item where("Carton commande" > field("Factures douanieres")));
            CalcFormula = count(Item where("Statut Livraison" = const(true), Blocked = const(false)));

        }
        field(35; Annulées; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where(Cancelled = const(true), "Due Date" = field(dateFilter)));
        }
        field(30; "Commande lancee"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where(Status = const(Released), "Document Type" = const(Order)));
        }
        field(31; "Conteneurs en chargement"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where(Situaion = const("Loaded"), "Document Type" = const(Order)));
        }
        field(36; "Conteneurs Embarqués"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where(Situaion = const("Embedded"), "Document Type" = const(Order)));
        }
        field(37; "Conteneurs en Approche"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where(Situaion = const("Dumped"), "Document Type" = const(Order)));
        }
        field(38; "Conteneurs à depoter"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("purchase Header" where("Depotage" = const(true), "Document Type" = const(Order)));
        }

        field(39; "Depots Bonus"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer where("Montant prime bonus" = filter('>0')));
        }

        field(41; "Montant épargne"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Depôt".Montant where(isBonus = const(true)));
        }


        field(42; "crédits en cours"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where(Credit = const(true), CreditP = const(true), Closed = const(false)));
        }

        field(43; "DepotsCorrectionAttente"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Depôt" where(DemandeApprobation = const(true), Correction = const(false), validated = const(false)));
        }

        field(44; "DuplicataAttente"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where("Demande approbation" = const(true), Approuve = const(false)));
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