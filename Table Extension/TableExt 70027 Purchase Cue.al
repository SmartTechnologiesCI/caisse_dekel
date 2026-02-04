tableextension 70027 "Purchase Cue" extends "Purchase Cue"
{
    fields
    {
        field(60000; "Ticket du jour"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Date validation" = field("date filter 3"), Valide = const(true), "Statut paiement" = const(false), "Type opération" = const('ACHAT DIRECT')));
        }
        field(60001; "date filter 3"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(60002; "date filter 2"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(60003; "Ticke Anterieur non paye"; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Weighing 1 Date" = field("date filter 4"), Valide = const(true), "Statut paiement" = const(false), "Type opération" = const('ACHAT DIRECT   ')));
        }
        field(60004; "Ticket(s) Facturé(s) du jour"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Date validation" = field("date filter 3"), "Statut paiement" = const(true)));

        }
        field(60005; "Ticket du jour Planteur"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Date validation" = field("date filter 3"), Valide = const(true), "Statut paiement Planteur" = const(false)));
        }
        field(60006; "Ticket(s) Facturé(s) du jour Planteur"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Date validation" = field("date filter 3"), "Statut paiement Planteur" = const(true)));

        }
        field(60007; "Ticke Anterieur non paye Planteur"; Integer)
        {

            FieldClass = FlowField;

            CalcFormula = count("Item Weigh Bridge" where("Weighing 1 Date" = field("date filter 4"), Valide = const(true), "Statut paiement Planteur" = const(false)));
        }
        field(60008; "Ticket(s) Facturé(s) Planteur"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Statut paiement Planteur" = const(true)));
            Caption = 'Ticket(s) planteur(s) payé(s)';

        }
        field(60009; "Ticket du jour non payés"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Date validation" = field("date filter 3"), Valide = const(true), Statut_Total_Paiement = const(false)));

        }
        field(60010; "Ticket non  payés"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where(Valide = const(true), Statut_Total_Paiement = const(false)));

        }
        field(60011; "Ticket En attente paiement"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where(Valide = const(true), En_Attente_Paiement = const(true)));

        }
        field(60012; "Date filter 4"; Date)
        {
            FieldClass = FlowFilter;
        }
        //*************************Piles annulation de tickets
        field(60013; EnvoyEnAnnulation; Integer)
        {

            FieldClass = FlowField;
            Caption = 'Envoyé(s) en annulation';
            CalcFormula = count("Item Weigh Bridge" where("Envoyé en annulation" = const(true), TicketAnnule = const(false)));
        }
        field(60014; DemandeAutorisation; Integer)
        {
            Caption = 'Demande d''autorisation d''annulation';
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Envoyé en annulation" = const(true),"Autorisé à être annulé" = const(false)));
        }
        field(60015; TicketAAnnule; Integer)
        {

            FieldClass = FlowField;
            Caption = 'Ticket(s )à annulé(s)';
            CalcFormula = count("Item Weigh Bridge" where("Autorisé à être annulé" = const(true),TicketAnnule = const(false)));

        }
        // field(60016; AnnuleOption; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionMembers = " ","Envoyé en annulation","Annulation refusée","Annulé","Autorisé à être annulé";

        //     // Caption = 'Annulé';
        // }
        //*************************Piles annulation de tickets


    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}