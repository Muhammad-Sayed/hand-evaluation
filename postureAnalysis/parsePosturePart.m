function [ postureEnc ] = parsePosturePart( str, postureEnc )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%   This function is part of a very rough implementation of a posture parser
%   This function performs parsing on a single line

%digitFlag = false(1,5);

% Parsing descriptions begining with "The hand" (overrides the full description)
k = regexpi(str, 'hand');
if ~isempty(k)
    k = regexpi(str, 'tightly closed');
    if ~isempty(k)
        % Hand is tightly closed
        % All joints of all fingers are `fully bent'
        %postureEnc = [ 2 2 2 4 4 4 4 4 4 4 4 4 4 4 4 2 1 2 1 1 ];
        postureEnc = [ 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 2 1 2 1 1 ];
    else
        k = regexpi(str, 'closed');
        if ~isempty(k)
            % Hand is closed
            % MCP & PIP joints of all fingers `fully bent', DIP is straight
            %postureEnc = [ 2 2 2 4 4 1 4 4 1 4 4 1 4 4 1 2 1 2 1 1 ];
            postureEnc = [ 2 2 2 3 3 1 3 3 1 3 3 1 3 3 1 2 1 2 1 1 ];
        else
            k = regexpi(str, 'open');
            if ~isempty(k)
                % Hand is open ( default posture )
                % All digits seperated, extended, and straight
                %postureEnc = [ 4 4 4 1 1 1 1 1 1 1 1 1 1 1 1 2 1 2 1 1 ];
                postureEnc = [ 3 3 3 1 1 1 1 1 1 1 1 1 1 1 1 2 1 2 1 1 ];
            else
                k = regexpi(str, 'flat');
                if ~isempty(k)
                    % Hand is flat
                    % All fingers are together, extended, and straight
                    postureEnc = [ 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1 2 1 2 1 1 ];
                end
            end
        end
    end
end


k = regexpi(str, 'thumb');
% Parsing descriptions of fingers (without "thumb")
if isempty(k)
    k = regexpi(str, 'upper fingers');
    if ~isempty(k)
        postureEnc = parseSepration(str, postureEnc, 1);
        % Posture description of upper fingers, set flags 2 to 3
        digitFlag = [ false true true false false ];
        % Parse flexion state
        postureEnc = parseFlexion(str, postureEnc, digitFlag);
    else
        k = regexpi(str, 'lower fingers');
        if ~isempty(k)
            postureEnc = parseSepration(str, postureEnc, 2);
            % Posture description of lower fingers, set flags 4 to 5
            digitFlag = [ false false false true true ];
            % Parse flexion state
            postureEnc = parseFlexion(str, postureEnc, digitFlag);
        else
            k = regexpi(str, 'fingers');
            if ~isempty(k)
                postureEnc = parseSepration(str, postureEnc, 3);
                % Posture description of all fingers, set flags 2 to 5
                digitFlag = [ false true true true true ];
                % Parse flexion state
                postureEnc = parseFlexion(str, postureEnc, digitFlag);
            else
                k = regexpi(str, 'index');
                if ~isempty(k)
                    % Posture description of index, set flag 2
                    digitFlag = [ false true false false false ];
                    % Parse flexion state
                    postureEnc = parseFlexion(str, postureEnc, digitFlag);
                else
                    k = regexpi(str, 'middle');
                    if ~isempty(k)
                        % Posture description of middle finger, set flag 3
                        digitFlag = [ false false true false false ];
                        % Parse flexion state
                        postureEnc = parseFlexion(str, postureEnc, digitFlag);
                    else
                        k = regexpi(str, 'ring');
                        if ~isempty(k)
                            % Posture description of ring finger, set flag 4
                            digitFlag = [ false false false true false ];
                            % Parse flexion state
                            postureEnc = parseFlexion(str, postureEnc, digitFlag);
                        else
                            k = regexpi(str, 'small');
                            if ~isempty(k)
                                % Posture description of small finger, set flag 5
                                digitFlag = [ false false false false true ];
                                % Parse flexion state
                                postureEnc = parseFlexion(str, postureEnc, digitFlag);
                            end
                        end
                    end
                end
            end
        end
    end
else % parsing thumb descriptions
    % Posture description of thumb, set flag 1
    digitFlag = [ true false false false false ];
    % Parse flexion state
    postureEnc = parseFlexion(str, postureEnc, digitFlag);
    % Parse opposition
    k = regexpi(str, 'opposition');
    if ~isempty(k)
        postureEnc(16) = 2;
        postureEnc(18) = 0; % radial abduction only exist in retroposition
    else
        k = regexpi(str, 'retropostion');
        if ~isempty(k)
            postureEnc(16) = 1;
            % Parse radial abduction
            k = regexpi(str, 'adjacent');
            if ~isempty(k)
                postureEnc(18) = 1;
            else
                k = regexpi(str, 'far');
                if ~isempty(k)
                    postureEnc(18) = 2;
                end
            end
        end
    end
    % Parse palmar abduction
    k = regexpi(str, 'adducted');
    if ~isempty(k)
        postureEnc(17) = 1;
    else
        k = regexpi(str, 'abducted');
        if ~isempty(k)
            postureEnc(17) = 2;
        end
    end
end

end


function postureEnc = parseSepration(str, postureEnc, n)
% Local function to parse finger separation only

k = regexpi(str, 'crossing');
if ~isempty(k)
    if n == 1 % upper fingers
        postureEnc(1) = 1;
    elseif n == 2 % lower fingers
        postureEnc(3) = 1;
    else % all fingers
        postureEnc(1:3) = [ 1 1 1 ];
    end
else
    k = regexpi(str, 'together');
    if ~isempty(k)
        if n == 1 % upper fingers
            postureEnc(1) = 2;
        elseif n == 2 % lower fingers
            postureEnc(3) = 2;
        else % all fingers
            postureEnc(1:3) = [ 2 2 2 ];
        end
    else
        %k = regexpi(str, 'slightly separated');
        k = regexpi(str, 'separated');
        if ~isempty(k)
            if n == 1 % upper fingers
                postureEnc(1) = 3;
            elseif n == 2 % lower fingers
                postureEnc(3) = 3;
            else % all fingers
                postureEnc(1:3) = [ 3 3 3 ];
            end
%         else
%             k = regexpi(str, 'separated');
%             if ~isempty(k)
%                 if n == 1 % upper fingers
%                     postureEnc(1) = 4;
%                 elseif n == 2 % lower fingers
%                     postureEnc(3) = 4;
%                 else % all fingers
%                     postureEnc(1:3) = [ 4 4 4 ];
%                 end
%             end
        end
    end
end

end


function postureEnc = parseFlexion(str, postureEnc, digitFlag)
% Parsing the flexion state of the fingers or thumb
%
%   Fingers can have any of the following states:
%   # MCP => extended, (slightly/-/fully) bent at first knuckle
%   # PIP and DIP => straight, (slightly) curved, curled
%   #               (slightly/-/fully) bent at second/third knuckle
%
%   Thumb can have and of the following states:
%   # extended, curved, straight, (slightly/-/fully) bent at first/second knuckle

% "extended"; applies only to MCP of all digits
k = regexpi(str, 'extended');
if ~isempty(k)
    if digitFlag(1) % thumb
        postureEnc(19) = 1;
    else
        for i = 2:5 % fingers
            if digitFlag(i)
                x = ((i-1) * 3 ) + 1; % pointer to MCP joint state in postureEnc
                postureEnc(x) = 1;
            end
        end
    end
else % "(slightly/-/fully) bent at first knuckle"; applies only to MCP of all digits
    k = regexpi(str, 'slightly bent at first knuckle');
    if ~isempty(k)
        if digitFlag(1) % thumb
            postureEnc(19) = 2;
        else
            for i = 2:5 % fingers
                if digitFlag(i)
                    x = ((i-1) * 3 ) + 1; % pointer to MCP joint state in postureEnc
                    postureEnc(x) = 2;
                end
            end
        end
    else
%         k = regexpi(str, 'fully bent at first knuckle');
%         if ~isempty(k)
%             if digitFlag(1) % thumb
%                 postureEnc(19) = 4;
%             else
%                 for i = 2:5 % fingers
%                     if digitFlag(i)
%                         x = ((i-1) * 3 ) + 1; % pointer to MCP joint state in postureEnc
%                         postureEnc(x) = 4;
%                     end
%                 end
%             end
%         else
            k = regexpi(str, 'bent at first knuckle');
            if ~isempty(k)
                if digitFlag(1) % thumb
                    postureEnc(19) = 3;
                else
                    for i = 2:5 % fingers
                        if digitFlag(i)
                            x = ((i-1) * 3 ) + 1; % pointer to MCP joint state in postureEnc
                            postureEnc(x) = 3;
                        end
                    end
                end
            end
        %end
    end
end

% "(slightly) curved"; applies to thumb MCP and IP, and fingers' PIP and DIP
%k = regexpi(str, 'slightly curved');
k = regexpi(str, 'curved');
if ~isempty(k)
    if digitFlag(1) % thumb
        postureEnc(19) = 2;
        postureEnc(20) = 2;
    else
        for i = 2:5 % fingers
            if digitFlag(i)
                x = ((i-1) * 3 ) + 2; % pointer to PIP joint state in postureEnc
                postureEnc(x:x+1) = [ 2 2 ];
            end
        end
    end
% else
%     k = regexpi(str, 'curved');
%     if ~isempty(k)
%         if digitFlag(1) % thumb
%             postureEnc(19) = 3;
%             postureEnc(20) = 3;
%         else
%             for i = 2:5 % fingers
%                 if digitFlag(i)
%                     x = ((i-1) * 3 ) + 2; % pointer to PIP joint state in postureEnc
%                     postureEnc(x:x+1) = [ 3 3 ];
%                 end
%             end
%         end
%     end
end

% "curled"; applies to fingers' PIP and DIP
k = regexpi(str, 'curled');
if ~isempty(k)
    for i = 2:5 % fingers
        if digitFlag(i)
            x = ((i-1) * 3 ) + 2; % pointer to PIP joint state in postureEnc
            postureEnc(x:x+1) = [ 3 3 ];
        end
    end
end

% "straight"; applies to thumb IP and fingers' PIP and DIP
k = regexpi(str, 'straight');
if ~isempty(k)
    if digitFlag(1) % thumb
        postureEnc(20) = 1;
    else
        for i = 2:5 % fingers
            if digitFlag(i)
                x = ((i-1) * 3 ) + 2; % pointer to PIP joint state in postureEnc
                postureEnc(x:x+1) = [ 1 1 ];
            end
        end
    end
else
    % "(slightly/-/fully) bent at second knuckle"; applies to thumb IP and fingers' PIP
    k = regexpi(str, 'slightly bent at second knuckle');
    if ~isempty(k)
        if digitFlag(1) % thumb
            postureEnc(20) = 2;
        else
            for i = 2:5 % fingers
                if digitFlag(i)
                    x = ((i-1) * 3 ) + 2; % pointer to PIP joint state in postureEnc
                    postureEnc(x) = 2;
                end
            end
        end
    else
%         k = regexpi(str, 'fully bent at second knuckle');
%         if ~isempty(k)
%             if digitFlag(1) % thumb
%                 postureEnc(20) = 4;
%             else
%                 for i = 2:5 % fingers
%                     if digitFlag(i)
%                         x = ((i-1) * 3 ) + 2; % pointer to PIP joint state in postureEnc
%                         postureEnc(x) = 4;
%                     end
%                 end
%             end
%         else
            k = regexpi(str, 'bent at second knuckle');
            if ~isempty(k)
                if digitFlag(1) % thumb
                    postureEnc(20) = 3;
                else
                    for i = 2:5 % fingers
                        if digitFlag(i)
                            x = ((i-1) * 3 ) + 2; % pointer to PIP joint state in postureEnc
                            postureEnc(x) = 3;
                        end
                    end
                end
            end
        %end
    end
    % "(slightly/-/fully) bent at third knuckle"; applies to fingers' DIP
    k = regexpi(str, 'slightly bent at third knuckle');
    if ~isempty(k)
        for i = 2:5 % fingers
            if digitFlag(i)
                x = ((i-1) * 3 ) + 3; % pointer to DIP joint state in postureEnc
                postureEnc(x) = 2;
            end
        end
    else
%         k = regexpi(str, 'fully bent at third knuckle');
%         if ~isempty(k)
%             for i = 2:5 % fingers
%                 if digitFlag(i)
%                     x = ((i-1) * 3 ) + 3; % pointer to DIP joint state in postureEnc
%                     postureEnc(x) = 4;
%                 end
%             end
%         else
            k = regexpi(str, 'bent at third knuckle');
            if ~isempty(k)
                for i = 2:5 % fingers
                    if digitFlag(i)
                        x = ((i-1) * 3 ) + 3; % pointer to DIP joint state in postureEnc
                        postureEnc(x) = 3;
                    end
                end
            end
        %end
    end
end

end
