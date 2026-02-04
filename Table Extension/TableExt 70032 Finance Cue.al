tableextension 70032 "Finance Cue" extends "Finance Cue"
{
    fields
    {
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