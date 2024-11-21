function [time_events, queue_len] = simulate_queue(arrival_times, service_times, time_limit)
    N = length(arrival_times);
    time_events = zeros(1, N); 
    queue_len = zeros(1, N); 

    current_time = 0;
    in_service = 0; 

    for i = 1:N
        if current_time < time_limit
            if i == 1
                time_events(i) = arrival_times(i) + service_times(i);
                current_time = time_events(i);
                queue_len(i) = 0;
            else
                current_time = current_time + arrival_times(i);
                if current_time > time_events(i-1)
                    queue_len(i) = 0;
                else
                    queue_len(i) = time_events(i-1) - current_time;
                end
                time_events(i) = current_time + service_times(i) + queue_len(i);
            end
        else
            break;
        end
    end
end